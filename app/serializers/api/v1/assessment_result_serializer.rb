class Api::V1::AssessmentResultSerializer < Api::V1::ApplicationSerializer
  attributes :user, :assessment, :score, :status, :answers, :grade

  def answers
    ActiveModel::SerializableResource.new(object.answers,  each_serializer: Api::V1::AnswerSerializer)
  end

  def grade
    object.grade
  end
end
