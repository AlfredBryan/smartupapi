class Api::V1::GradingSystemsController < Api::V1::Resources::BaseController
  def index
    @grading_systems = policy_scope(GradingSystem)
    render json: @grading_systems.map {|grading_system| Api::V1::GradingSystemSerializer.new(grading_system).as_json}
  end

  private

  def grading_system_params
    params.require(:grading_system).permit(:id, :institution_id, :course_id, :_destroy,
                                           grading_scores_attributes: [:id, :name, :score, :_destroy])
  end
end
