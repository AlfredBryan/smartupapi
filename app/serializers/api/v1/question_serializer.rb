class Api::V1::QuestionSerializer < Api::V1::ApplicationSerializer
  attributes :name, :description, :topic_id, :answer_options

  def answer_options
    ActiveModel::SerializableResource.new(object.answer_options,  each_serializer: AnswerOptionSerializer)
  end
end
