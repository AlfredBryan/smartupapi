class WardRequest < ApplicationRecord
  belongs_to :user
  belongs_to :guardian, class_name: 'User', foreign_key: :guardian_id
end
