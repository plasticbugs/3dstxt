class AddCommentAlertToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :comment_alert, :boolean, :default => 0
  end

  def self.down
    remove_column :users, :comment_alert
  end
end
