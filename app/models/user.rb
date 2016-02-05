class User < ActiveRecord::Base
  has_many :friendships,:dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, length: { minimum: 6 }, unless: Proc.new { |user| user.password.nil? }
  validates :password_confirmation, presence: true, unless: Proc.new { |user| user.password.nil? }

  has_secure_password
#comment
# Oleg comment
  def generate_auth_token
    self.token = SecureRandom.uuid.gsub(/\-/,'')
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
