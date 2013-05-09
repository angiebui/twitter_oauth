get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
  # authorize_url is a method on the OAuth::Consumer object in helpers

end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  @user = User.create(:username => @access_token.params[:screen_name], :oauth_secret => @access_token.secret, :oauth_token => @access_token.token)
  # at this point in the code is where you'll need to create your user account and store the access token

  erb :index
  
end

get '/status/:job_id' do
  status = job_is_complete(params["job_id"])
  if status == false
    return "Not done yet!"
  else 
    return "Posted!"
  end
end

