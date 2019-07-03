class Api::V1::MaximumScoreSerializer < Api::V1::ApplicationSerializer
  attributes :score, :question_id, :assessment_id
end
