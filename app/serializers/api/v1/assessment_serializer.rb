class Api::V1::AssessmentSerializer < Api::V1::ApplicationSerializer
  attribute :name, :description, :course_id
end
