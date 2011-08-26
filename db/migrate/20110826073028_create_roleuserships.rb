class CreateRoleuserships < ActiveRecord::Migration
  def self.up
    create_table :roleuserships do |t|

      t.references :user, :role
      
    end
  end

  def self.down
    drop_table :roleuserships
  end
end
