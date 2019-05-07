class Api::V1::AnswerOptionSerializer < Api::V1::ApplicationSerializer
  attribute :rank, :content, 
  attribute :question_id, :correct
end
