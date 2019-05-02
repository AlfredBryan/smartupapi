class User < ApplicationRecord

  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable

  STATUSES = %w(student guardian educator)

  scope :with_email, ->(email) { where(email: email.downcase) }
  scope :with_email_and_token, ->(email, token) { with_email(email).where(authentication_token: token) }

  validates :status, presence: true, inclusion: { in: STATUSES }

  def reset_authentication_token!
    update_column(:authentication_token, Devise.friendly_token)
  end
end
