class GroupMembership < ApplicationRecord
  belongs_to :user
  belongs_to :study_group

  attr_accessor :user_emails
end
