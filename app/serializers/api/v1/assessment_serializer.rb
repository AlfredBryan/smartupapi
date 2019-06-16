class Api::V1::AssessmentSerializer < Api::V1::ApplicationSerializer
  attributes :name, :description, :course, :assessment_questions, :questions

  def questions
    ActiveModel::SerializableResource.new(object.questions,  each_serializer: Api::V1::QuestionSerializer)
  end

  def assessment_questions
    ActiveModel::SerializableResource.new(object.assessment_questions,  each_serializer: Api::V1::AssessmentQuestionSerializer)
  end
end
