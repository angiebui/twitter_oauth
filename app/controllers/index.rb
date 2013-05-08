get '/' do
  erb :index
end

post '/tweet' do
  user_id = session[:user_id] 
  @user = User.find(user_id)

  @user.tweet(params[:tweet])
end


get '/sign_in' do
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

  session.delete(:request_token)

  # find or create by later
  @user = User.create(:username => @access_token.params[:screen_name], :oauth_secret => @access_token.secret, :oauth_token => @access_token.token)
  
  session[:user_id] = @user.id
  erb :index
end

get '/status/:job_id' do
  status = job_is_complete(params["job_id"])
  if status == false
    return "Not done yet!"
  else 
    return "Posted!"
  end
  # h = {status: status}
  # p "this is the status hash/object"
  # p h
end

