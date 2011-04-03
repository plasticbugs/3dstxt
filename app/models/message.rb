class Message < ActiveRecord::Base
  before_validation(:create_code_until_valid, :on => :create)
    
  validates :pickUpCode, :uniqueness => true
  validates_length_of :contents,
                      :minimum => 1,
                      :maximum => 5000

private
  def create_code_until_valid(size = 5)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z a b d e f g h k m n q r t w x y }
    self.pickUpCode ||= (0...size).map{ charset.to_a[rand(charset.size)] }.join
    
    while Message.find_by_pickUpCode(self.pickUpCode, size = 5)
      self.pickUpCode = (0...size).map{ charset.to_a[rand(charset.size)] }.join
    end
  end
end
