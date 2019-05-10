class Api::V1::GradingSystemSerializer < Api::V1::ApplicationSerializer
  attributes :course_id, :institution_id, :grading_scores
end
