class Api::V1::AnswerSerializer < Api::V1::ApplicationSerializer
  attribute :state, :content, :content_url, :question_id, :answer_option_id, :user_id
end
