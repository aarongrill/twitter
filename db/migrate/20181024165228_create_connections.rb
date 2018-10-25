class CreateConnections < ActiveRecord::Migration[5.2]
def up
create_table :connections do |t|
  		t.integer :user_id
  		t.integer :follower_id
  	end
  end
   def down
  	drop_table :connections
  end
end