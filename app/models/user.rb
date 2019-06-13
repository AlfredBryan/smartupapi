require 'file_size_validator'

class User < ApplicationRecord

  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable

  STATUSES = %w(student guardian educator)
  SEXES = %w(male female other)
  ACADEMIC_LEVELS = (1..12).to_a

  mount_base64_uploader :image, ImageUploader

  has_many :answers
  has_many :assessment_results
  has_many :courses, class_name: 'User', foreign_key: :creator_id
  has_many :institutions, class_name: 'User', foreign_key: :owner_id

  has_many :ward_requests, foreign_key: :guardian_id
  has_many :ward_responses, class_name: 'WardRequest'
  has_many :wards, -> { where(ward_requests: { approved: true }) }, through: :ward_requests, source: :user
  has_many :guardians, -> { where(ward_requests: { approved: true }) }, through: :ward_responses, source: :guardian
  has_many :group_memberships
  has_many :study_groups, through: :group_memberships


  scope :with_email, ->(email) { where(email: email.downcase) }
  scope :with_email_and_token, ->(email, token) { with_email(email).where(authentication_token: token) }

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :sex, inclusion: { in: SEXES, allow_blank: true }
  validates :level, :numericality => { greater_than: 0, less_than_or_equal_to: ACADEMIC_LEVELS.last }
  validates :image, file_size: { maximum: 5.megabytes.to_i }

  after_save :setup_completed!

  STATUSES.each do |status|
    define_method "#{status}?" do
      self.status == status
    end
  end

  def reset_authentication_token!
    update_column(:authentication_token, Devise.friendly_token)
  end

  def to_s
    full_name.presence || email
  end

  def full_name
    "#{surname} #{first_name}"
  end

  def age
    Date.current.year - date_of_birth.year
  rescue
    nil
  end

  def image_url
    image.url
  end

  def complete?
    complete = true
    [:first_name, :surname, :address, :phone, :image_url, :state, :sex, :level, :date_of_birth].each do |attr|
      complete = complete && self.send(attr).present?
    end
    complete
  end

  def setup_completed!
    update_column(:completed_at, DateTime.current) if completed_at.nil? && complete?
  end
end
