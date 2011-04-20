class AddMessageCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :message_count, :integer, :default => 0
  end

  def self.down
    remove_column :users, :message_count
  end
end
