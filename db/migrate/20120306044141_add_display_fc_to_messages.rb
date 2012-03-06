class AddDisplayFcToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :display_fc, :boolean, :default => true
  end

  def self.down
    remove_column :messages, :display_fc
  end
end
