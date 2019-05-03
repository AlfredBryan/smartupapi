class Assessment < ApplicationRecord
  belongs_to :course

  validates :name, presence: true

  has_many :questions
  has_many :answers, through: :questions
  has_many :answer_options, through: :questions
end
