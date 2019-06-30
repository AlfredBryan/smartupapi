class Api::V1::AssessmentResultSerializer < Api::V1::ApplicationSerializer
  attributes :user, :assessment, :score, :status, :answers
end
