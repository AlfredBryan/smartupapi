class Assessment < ApplicationRecord
  belongs_to :course

  validates :name, presence: true

  has_many :assessment_questions
  has_many :questions, through: :assessment_questions
  has_many :answers, through: :questions

  def total_max_scores
    questions.collect { |question| question.max_score(self.id) }.sum
  end
end
