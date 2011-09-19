class CreateFriends < ActiveRecord::Migration
  def self.up
    create_table :friends do |t|
      t.integer  :inviter_id
      t.integer  :invited_id
      t.integer  :status,   :default => 0
      t.timestamps
    end
    
    add_index "friends", ["inviter_id", "invited_id"], :name => "index_friends_on_inviter_id_and_invited_id", :unique => true
    add_index "friends", ["invited_id", "inviter_id"], :name => "index_friends_on_invited_id_and_inviter_id", :unique => true
    
  end

  def self.down
    drop_table :friends
  end
end
