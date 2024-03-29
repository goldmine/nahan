class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_salt
      t.string :password_hash
      t.string :auth_token
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.boolean :enabled, :default => true
      t.datetime :last_login_at
      t.integer :points, :default => '0'
      t.integer :v_count, :default => '0'
      t.integer :p_count, :default => '0'
      t.integer :s_count, :default => '0'
      t.integer :c_count, :default => '0'
      t.string :ip_address
      t.text :desc
      t.string :name
      t.string :education
      t.string :location
      t.string :age
      t.string :gender
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.timestamps
    end
     
  end

  def self.down
    drop_table :users
  end
end
