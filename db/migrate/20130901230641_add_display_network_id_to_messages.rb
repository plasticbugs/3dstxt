class AddDisplayNetworkIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :display_network_id, :boolean, :default => true
  end
end
