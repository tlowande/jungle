class User < ActiveRecord::Base

  def self.authenticate_with_credentials(emailAddress, password)
    emailAddress.downcase!
    emailAddress.strip!
    user = User.find_by_email(emailAddress)
    user ? user.authenticate(password)? user : nil : nil
    
  end

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 4 }, confirmation: true
  validates :password_confirmation, presence: true, length: { minimum: 4 }
  before_save :sanitize_email
  
  def sanitize_email
    self.email.downcase!
    self.email.strip!
  end
  # before_save self.email.strip!
  # validates_uniqueness_of :email
end
