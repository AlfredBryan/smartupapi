class Attendance < ApplicationRecord
  belongs_to :study_group
  belongs_to :user

  validates :name, :marked_on, presence: true

  has_many :attendance_users
  has_many :attendees, through: :attendance_users, source: :user
end
