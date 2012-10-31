class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token


  before_save {|user| user.email = email.downcase} #  { self.email.downcase! } je ekvivalentni

  validates :name, presence: true, length: {maximum: 20}

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL}, uniqueness: {case_sensitive: false}

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private 

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end 
end
