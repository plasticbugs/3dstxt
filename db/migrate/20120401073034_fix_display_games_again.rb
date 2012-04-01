class FixDisplayGamesAgain < ActiveRecord::Migration
  def self.up
    add_column :messages, :display_games, :boolean, :default => true
    Message.update_all :display_games => true
  end

  def self.down
    remove_column :messages, :display_games
  end
end
