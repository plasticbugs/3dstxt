class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  before_save :encrypt_password
  
  validates(:name, :length => {:maximum => 50})
  validates(:email, :presence => true,
                    :uniqueness => {:case_sensitive => false})
  validates(:password, :presence => true,
                      :confirmation => true,
                      :length => {:within => 6..40})
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  private
  
  def encrypt_password
    self.encrypted_password = encrypt(password)
  end
  
  def encrypt(string)
    string
  end
  
end
