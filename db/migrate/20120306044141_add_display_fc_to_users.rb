class AddDisplayFcToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :display_fc, :boolean
  end

  def self.down
    remove_column :users, :display_fc
  end
end
