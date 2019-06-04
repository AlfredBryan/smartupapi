class Api::V1::QuestionSerializer < Api::V1::ApplicationSerializer
  attributes :name, :description, :topic_id, :answer_options
end
