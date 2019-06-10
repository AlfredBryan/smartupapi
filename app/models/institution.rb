require 'file_size_validator'

class Institution < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_many :courses

  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_base64_uploader :logo, LogoUploader

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :logo, file_size: { maximum: 5.megabytes.to_i }

  def logo_url
    logo.url
  end

end
