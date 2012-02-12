class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :code
      t.string :author
      t.string :author_email
      t.text :content
      t.integer :message_id
      t.integer :user_id
      t.string :permalink
      t.string :user_ip
      t.string :user_agent
      t.string :referrer
      t.string :comment_type
      t.string :author_url

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
