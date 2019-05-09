class Api::V1::QuestionsController < Api::V1::Resources::BaseController
  def index
    @questions = policy_scope(Question)
    render json: @questions.map {|question| Api::V1::QuestionSerializer.new(question).as_json}
  end

  private
  def question_params
    params.require(:question).permit(:id, :name, :description, :topic_id, :assessment_id, :_destroy,
                                           answer_options_attributes: [:id, :rank, :content, :question_id, :correct, :_destroy])
  end
end
