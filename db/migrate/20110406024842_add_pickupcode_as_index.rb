class AddPickupcodeAsIndex < ActiveRecord::Migration
  def self.up
    add_index :messages, :pickUpCode
  end

  def self.down
    remove_index :messages, :pickUpCode
  end
end
