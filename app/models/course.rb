class Course < ApplicationRecord
  belongs_to :institution, optional: true
  belongs_to :creator, class_name: 'User'

  has_many :topics, dependent: :destroy
  has_many :assessments, dependent: :destroy
  has_many :questions, through: :assessments

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :description, presence: true

end
