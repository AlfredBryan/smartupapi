class Institution < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_many :courses

  extend FriendlyId
  friendly_id :name, use: :slugged

end
