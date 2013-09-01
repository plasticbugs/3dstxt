class AddNetworkIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :network_id, :string
  end
end
