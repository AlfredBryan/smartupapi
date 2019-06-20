class GroupMembership < ApplicationRecord
  belongs_to :user
  belongs_to :study_group

  attr_accessor :user_emails

  validates :user_id, uniqueness: { scope: :study_group_id, message: "This user has already been added!" }
end
