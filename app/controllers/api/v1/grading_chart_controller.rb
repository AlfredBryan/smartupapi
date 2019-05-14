class Api::V1::GradingChartsController < Api::V1::Resources::BaseController

  def index
    @grading_charts = policy_scope(GradingChart.all)
    render json: @grading_charts.map {|chart| Api::V1::GradingChartSerializer.new(chart).as_json}
  end

  private

  def grading_chart_params
    params.require(:grading_chart).permit(:id, :institution_id, :course_id, :_destroy,
                                           grading_scores_attributes: [:id, :name, :score, :_destroy])
  end
end
