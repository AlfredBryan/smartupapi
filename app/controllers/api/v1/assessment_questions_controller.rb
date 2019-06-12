class Api::V1::AssessmentQuestionsController < Api::V1::Resources::BaseController
  before_action :find_assessment, except: :create
  skip_before_action :load_resource, only: :destroy

  def index
    @assessment_questions = policy_scope((@assessment.assessment_questions rescue []))
    render json: @assessment_questions.map {|assessment_question| Api::V1::AssessmentQuestionSerializer.new(assessment_question).as_json}
  end

  def create
    @assessment_question = :AssessmentQuestion.new(assessment_question_params)
    authorize(@assessment_question)
    if @assessment_question.save && @assessment_question.valid?
      render json: @assessment_question, serializer: serializer
    else
      render json: @assessment_question, serializer: serializer, status: :unprocessable_entity
    end
  end

  private

  def assessment_question_params
    params.require(:assessment_question).permit(:id, :assessment_id, :question_id, :_destroy)
  end

  def find_assessment
    @assessment = Assessment.find(params[:assessment_id]) if params[:assessment_id]
    @assessment_question = @assessment.assessment_questions.find_by_id(params[:id]) if @assessment
  end
end