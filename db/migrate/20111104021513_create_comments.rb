class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.text :body
      t.integer :article_id
      t.integer :ding_count, :default => 0
      t.string :ancestry
      t.timestamps
    end
    add_index :comments, :ancestry
  end

  def self.down
    drop_table :comments
    remove_index :comments, :ancestry
  end
end
