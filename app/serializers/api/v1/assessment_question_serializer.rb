class Api::V1::AssessmentQuestionSerializer < Api::V1::ApplicationSerializer
  attributes :assessment_id, :question, :max_score

  def max_score
    object.max_score
  end
end
