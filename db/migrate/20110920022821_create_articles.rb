class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.text :desc
      t.text :body
      t.string :link
      t.integer :category_id, :default => true
      t.boolean :voteble, :default => true
      t.boolean :commentable, :default => true
      t.boolean :pointable, :default => true
      t.boolean :suggestiontable, :default => true
      t.boolean :visible, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
