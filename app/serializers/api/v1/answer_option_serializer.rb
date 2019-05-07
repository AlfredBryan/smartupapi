class Api::V1::AnswerOptionSerializer < Api::V1::ApplicationSerializer
  attribute :rank, :content, :question_id
end 
