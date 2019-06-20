class AttendanceUser < ApplicationRecord
  belongs_to :user
  belongs_to :attendance

  validates :user_id, uniqueness: { scope: :attendance_id, message: "This user has already been added!" }
end
