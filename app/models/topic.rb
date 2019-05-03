class Topic < ApplicationRecord
  belongs_to :course

  has_many :questions, dependent: :destroy

  validates :name, :description, :course_id, presence: true

  def questions_with_answers
    questions.order(:rank).includes(:answers)
  end
end
