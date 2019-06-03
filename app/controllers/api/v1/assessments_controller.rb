class Api::V1::AssessmentsController < Api::V1::Resources::BaseController
  before_action :find_assessment, except: [:index, :create]

  def index
    @course = Course.friendly.find(params[:course_slug]) if params[:course_slug]
    @resource_scope = @course.assessments if @course
    @resource_scope ||= Assessment.all
    @assessments = policy_scope(@resource_scope)
    render json: @assessments.map {|assessment| Api::V1::AssessmentSerializer.new(assessment).as_json}
  end

  private

  def assessment_params
    params.require(:assessment).permit(:id, :name, :description, :course_id, :_destroy, answer_questions_attributes: [:id, :question_id])
  end

  def find_assessment
    @assessment = Assessment.find(params[:id])
  end

end
