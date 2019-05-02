class User < ApplicationRecord

  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, :trackable

  scope :with_email, ->(email) { where(email: email&.downcase) }
  scope :with_email_and_token, ->(email, token) { with_email(email).where(authentication_token: token) }
end
