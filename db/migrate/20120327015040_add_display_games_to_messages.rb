class AddDisplayGamesToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :display_games, :boolean, :default => true
    Message.update_all :display_games => true
  end
end