class User < ApplicationRecord
  attr_accessor :activation_token

  before_save   :downcase_email
  before_create :create_activation_digest

  has_many :categories, dependent: :destroy
  has_many :tasks, through: :categories, dependent: :destroy

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name,     presence: true
  validates :password, presence: true,
                       length: { minimum: 8 },
                       allow_nil: true
  validates :email,    presence: true,
                       uniqueness: true,
                       format: { with: VALID_EMAIL_REGEX }

  before_save { self.email = email.downcase }

  # ランダムな22文字のトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    # ハッシュ生成のコスト(＝安全性) テスト環境:低, 本番環境:高
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  # トークンがダイジェストに一致したらtrue
  def authenticated?(token)
    digest = self.activation_digest
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
