class FixDisplayGames < ActiveRecord::Migration
  def up
    remove_column :messages, :display_games
    add_column :messages, :display_games, :boolean, :default => true
    Message.update_all :display_games => true
  end

  def down
    remove_column :messages, :display_games
    add_column :messages, :display_games, :boolean, :default => true
  end
end