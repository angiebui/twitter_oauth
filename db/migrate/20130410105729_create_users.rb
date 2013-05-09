class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :profile_img_url
      t.string :profile_description
      t.string :oauth_token
      t.string :oauth_secret
      t.timestamps
    end
  end
end
