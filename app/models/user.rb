class User < ApplicationRecord

  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable

  STATUSES = %w(student guardian educator)

  scope :with_email, ->(email) { where(email: email.downcase) }
  scope :with_email_and_token, ->(email, token) { with_email(email).where(authentication_token: token) }

  validates :status, presence: true, inclusion: { in: STATUSES }

  after_save :setup_completed!

  def reset_authentication_token!
    update_column(:authentication_token, Devise.friendly_token)
  end

  def to_s
    full_name.presence || email
  end

  def full_name
    "#{surname} #{first_name}"
  end

  def complete?
    complete = true
    [:first_name, :surname, :address, :phone, :image_url, :state].each do |attr|
      complete = complete && self.send(attr).present?
    end
    complete
  end

  def setup_completed!
    update_column(:completed_at, DateTime.current) if completed_at.nil? && complete?
  end
end
