class Api::V1::AssessmentSerializer < Api::V1::ApplicationSerializer
  attributes :name, :description, :course_id
end
