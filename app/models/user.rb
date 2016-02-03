class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  #validates :password, length: { minimum: 6 }, unless: Proc.new { |user| user.password.nil? }
  #validates :password_confirmation, presence: true, unless: Proc.new { |user| user.password.nil? }
  #validates_confirmation_of :password,
                            #if: lambda { |m| m.password.present? }
  #test
  has_secure_password

  def generate_auth_token
    self.token = SecureRandom.uuid.gsub(/\-/,'')
  end
end
