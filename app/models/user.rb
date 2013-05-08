class User < ActiveRecord::Base
  has_many :tweets
  
  def tweet(status)
    tweet = tweets.create!(:text => status)
    TweetWorker.perform_async(tweet.id)
  end

  def schedule_tweet(status, num)
    tweet = tweets.create(:text => status)
    TweetWorker.perform_in(num.days, tweet.id)
  end
end
