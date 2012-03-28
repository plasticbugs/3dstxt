class Game < ActiveRecord::Base
  belongs_to :user
  validates :asin, :uniqueness => {:message => "is already in your collection.", :scope => :user_id}
  validate :has_only_10_games, :on => :create
  
  def has_only_10_games
    if self.user.games.count > 9
      self.errors[:base] << "You can only save and display up to 10 of your favorite games in your collection."
    end
  end
  
end
