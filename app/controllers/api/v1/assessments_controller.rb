class Api::V1::AssessmentsController < Api::V1::Resources::BaseController
  before_action :find_assessment, except: [:index, :create]

  def index
    @course = Course.friendly.find(params[:course_slug]) if params[:course_slug]
    @resource_scope = @course.assessments if @course
    @resource_scope ||= Assessment.all
    @assessments = policy_scope(@resource_scope)
    render json: @assessments.map {|assessment| Api::V1::AssessmentSerializer.new(assessment).as_json}
  end

  def answer
    @answer = current_user.answers.where(question_id: answer_params[:question_id], assessment_id: @assessment.id).first_or_create
    @answer.update_attributes(answer_params)
    render json: Api::V1::AnswerSerializer.new(@answer).as_json
  end

  def finish
    @result = current_user.assessment_results.where(assessment_id: @assessment.id).first_or_create
    @result.mark!
    render json: Api::V1::AssessmentResultSerializer.new(@result).as_json
  end

  private

  def answer_params
    params.require(:answer).permit(:id, :state, :assessment_id, :question_id, :answer_option_id, :content, :user_id, :_destroy)
  end

  def assessment_params
    params.require(:assessment).permit(:id, :name, :description, :course_id, :_destroy)
  end

  def find_assessment
    @assessment = Assessment.find(params[:id])
  end

end
