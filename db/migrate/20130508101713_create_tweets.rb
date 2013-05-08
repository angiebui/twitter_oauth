class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.integer :twitter_tweet_id
      t.references :user
      t.timestamps
    end
  end
end
