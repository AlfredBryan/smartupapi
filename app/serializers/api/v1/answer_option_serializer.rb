class Api::V1::AnswerOptionSerializer < Api::V1::ApplicationSerializer
  attributes :rank, :content, :question_id, :correct
end
