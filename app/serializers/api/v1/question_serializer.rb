class Api::V1::QuestionSerializer < Api::V1::ApplicationSerializer
  attributes :name, :description, :topic_id, :answer_options, :question_type

  def answer_options
    ActiveModel::SerializableResource.new(object.answer_options,  each_serializer: Api::V1::AnswerOptionSerializer)
  end
end
