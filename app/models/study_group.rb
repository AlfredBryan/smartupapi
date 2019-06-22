class StudyGroup < ApplicationRecord
  belongs_to :institution
  has_many :group_memberships
  has_many :members, through: :group_memberships, source: :user

  has_many :attendances

  ACADEMIC_LEVELS = (1..12).to_a

  validates :name, :level, presence: true
  validates :level, :numericality => { greater_than: 0, less_than_or_equal_to: ACADEMIC_LEVELS.last }

end
