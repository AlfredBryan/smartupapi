class Api::V1::AssessmentSerializer < Api::V1::ApplicationSerializer
  attributes :name, :description, :course, :questions

  def questions
    ActiveModel::SerializableResource.new(object.questions,  each_serializer: Api::V1::QuestionSerializer)
  end
end
