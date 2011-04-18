class Message < ActiveRecord::Base
   belongs_to :user
#  after_validation(:my_method)
  
  validates :pickUpCode, :uniqueness => {:case_sensitive => false}
  validates_length_of :pickUpCode, :minimum => 3, :maximum => 5, :if => :pickUpCode
  validates_length_of :contents,
                      :minimum => 1,
                      :maximum => 5000
  
  # before_validation do
  #   if signed_in?
  #     if self.pickUpCode.blank?
  #       charset = %w{ 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z }
  #       self.pickUpCode = (0...5).map{ charset.to_a[rand(charset.size)] }.join
  # 
  #       while Message.find_by_pickUpCode(self.pickUpCode.downcase)
  #         self.pickUpCode = (0...5).map{ charset.to_a[rand(charset.size)] }.join
  #       end
  #     end
  #   end
  # end
  
  before_validation(:if_blank)
  #before_save(:create_code_until_valid, :downcase_pickUpCode)
  
  after_validation(:create_code_until_valid) #, :on => :create)
  

private

  def if_blank
     if self.pickUpCode.blank?
       self.pickUpCode = nil
     end
  end

  def downcase_pickUpCode
    self.pickUpCode = self.pickUpCode.downcase
  end

  def create_code_until_valid(size = 5)
    charset = %w{ 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z }
    self.pickUpCode ||= (0...size).map{ charset.to_a[rand(charset.size)] }.join
    
    while Message.find_by_pickUpCode(self.pickUpCode.downcase, size = 5)
      self.pickUpCode = (0...size).map{ charset.to_a[rand(charset.size)] }.join
    end
  end
end
