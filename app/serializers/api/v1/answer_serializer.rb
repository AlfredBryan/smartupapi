class Api::V1::AnswerSerializer < Api::V1::ApplicationSerializer
  attributes :state, :content, :content_url, :question, :assessment_id, :answer_option_id, :user_id
end
