class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  has_many :orders, dependent: :destroy
  has_one :profile, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w\-.+]+@[a-z\-\d.]+\.[a-z]+\z/i.freeze
  before_save :downcase_email
  before_create :create_activation_digest
  validates :email, format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false},
                    length: {maximum: Settings.model.user.email_max},
                    presence: true,
                    allow_blank: true
  validates :password,  length: {minimum: Settings.model.user.password_min},
                        presence: true,
                        allow_blank: true
  has_secure_password

  enum role: {user: 0, admin: 1}

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_column :remember_digest, nil
  end

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
