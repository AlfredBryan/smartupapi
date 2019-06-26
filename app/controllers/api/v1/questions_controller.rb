class Api::V1::QuestionsController < Api::V1::Resources::BaseController

  def index
    @course = Course.friendly.find(params[:course_slug]) if params[:course_slug]
    @questions = policy_scope((@course.questions rescue nil) || Question.all)
    render json: @questions.map {|question| Api::V1::QuestionSerializer.new(question).as_json}
  end

  private

  def question_params
    params.require(:question).permit(:id, :name, :description, :topic_id, :question_type, :max_score, :_destroy)
  end
end
