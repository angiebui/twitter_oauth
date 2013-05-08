# to restart sidekiq/reddis, quit then
# bundle exec sidekiq -r./config/environment.rb 

class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user  = tweet.user

    secret = user.oauth_secret 
    token = user.oauth_token

    twitter_client = Twitter::Client.new(
      :consumer_key => ENV['TWITTER_KEY'],
      :consumer_secret => ENV['TWITTER_SECRET'],
      :oauth_token => token, 
      :oauth_token_secret => secret
      )

    twitter_client.update(tweet.text)
  end

  def oauth_consumer
    @consumer ||= OAuth::Consumer.new(
      ENV['TWITTER_KEY'],
      ENV['TWITTER_SECRET'],
      :site => "https://api.twitter.com"
      )
  end

  def request_token
    if not session[:request_token]
  
    host_and_port = request.host
    host_and_port << ":9393" if request.host == "localhost"

    session[:request_token] = oauth_consumer.get_request_token(
      :oauth_callback => "http://#{host_and_port}/auth"
      )
    end
  session[:request_token]
  end
end