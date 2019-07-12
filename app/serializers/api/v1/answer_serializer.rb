class Api::V1::AnswerSerializer < Api::V1::ApplicationSerializer
  attributes :state, :content, :content_url, :question, :assessment_id, :answer_option, :user_id, :score, :theory_score_pct

  def theory_score_pct
    object.theory_score_pct
  end

  def question
    ActiveModel::SerializableResource.new(object.question,  serializer: Api::V1::QuestionSerializer)
  end
end
