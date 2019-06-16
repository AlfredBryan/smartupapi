class Question < ApplicationRecord
  belongs_to :topic

  has_many :answers, dependent: :destroy
  # has_many :comments, dependent: :destroy

  has_many :answer_options, dependent: :destroy
  has_many :assessment_questions, dependent: :destroy

  validates :name, :description, presence: true

end
