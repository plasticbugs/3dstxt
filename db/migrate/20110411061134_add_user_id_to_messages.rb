class AddUserIdToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :user_id, :integer
    add_index :messages, :user_id
  end

  def self.down
    remove_index :messages, :user_id
    remove_column :messages, :user_id
    
  end
end
