class AssessmentQuestion < ApplicationRecord
  belongs_to :assessment
  belongs_to :question

  validates :question_id, uniqueness: { scope: :assessment_id, message: "This question has already been added!" }

  def max_score
    question.max_score(assessment_id)
  rescue
    0
  end
end
