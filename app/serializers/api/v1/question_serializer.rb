class Api::V1::QuestionSerializer < Api::V1::ApplicationSerializer
  attributes :name, :description, :topic_id, :assessment_id, :answer_options
end
