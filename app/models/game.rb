class Game < ActiveRecord::Base
  belongs_to :user
  validates :asin, :uniqueness => {:message => "is already in your collection."}
  
end
