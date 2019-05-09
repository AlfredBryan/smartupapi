class WardRequest < ApplicationRecord
  belongs_to :user
  belongs_to :guardian, class_name: 'User', foreign_key: :guardian_id

  validates :guardian, uniqueness: { scope: :user_id, message: "Already has a ward request!" }

  attr_accessor :email

  scope :pending, -> { where(approved: false) }
end
