class AssessmentQuestion < ApplicationRecord
  belongs_to :assessment
  belongs_to :question

  validates :question_id, uniqueness: { scope: :assessment_id, message: "This question has already been added!" }
end
