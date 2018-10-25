class CreateTweets < ActiveRecord::Migration[5.2]
  def up
  	create_table :tweets do |t|
  		t.string :user_id
  		t.string :message
  		t.string :hashtags
  		t.string :media_url
  		t.timestamps
  	end
  end
   def down
  	drop_table :tweets
  end
end