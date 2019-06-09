class Institution < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_many :courses

  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_base64_uploader :logo, LogoUploader

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

end
