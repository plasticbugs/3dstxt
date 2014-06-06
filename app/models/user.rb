require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :comment_alert, :friend_code, :profile_pic, :network_id
    
  has_many :messages, :dependent => :destroy
  has_many :comments
  has_many :games
  
  
  has_attached_file :profile_pic,
                    :storage => :s3,
                    :s3_credentials => {:access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']},
                    :bucket => ENV['S3_BUCKET'],
                    :styles=> { :medium => "250x250>", :thumb => "100x100>"},
                    :path => "/:style/:id/:filename"
    
  validates(:name, :length => {:maximum => 50})
  validates(:email, :presence => true,
                    :uniqueness => {:case_sensitive => false})
  validates(:password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40},
                       :if => :password_present?)

  before_create :downcase_email
  before_save :encrypt_password
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def password_present?
    !password.nil?
  end
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
 
  
  private
  
  def downcase_email
    self.email = self.email.downcase
  end
  
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password) if password.present?
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
  
  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.base64.tr("+/", "-_")
    end while User.exists?(column => self[column])
  end
    
end
