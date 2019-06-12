class Api::V1::AssessmentResultsController < Api::V1::Resources::BaseController
  before_action :find_assessment
  skip_before_action :load_resource, only: :destroy

  def index
    @assessment_results = policy_scope((@assessment.assessment_results rescue []))
    render json: @assessment_results.map {|assessment_result| Api::V1::AssessmentResultSerializer.new(assessment_result).as_json}
  end

  private

  def find_assessment
    @assessment = Assessment.find(params[:assessment_id]) if params[:assessment_id]
    @assessment_result = @assessment.assessment_results.find_by_id(params[:id]) if @assessment
  end
end