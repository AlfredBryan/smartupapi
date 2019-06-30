class Api::V1::AnswersController < Api::V1::Resources::BaseController
  before_action :find_answer, except: [:index, :create]
  skip_before_action :load_resource, only: :index

  def index
    @assessment = Assessment.find(params[:assessment_id]) if params[:assessment_id]
    @answers = policy_scope((@assessment.answers.where(user_id: params[:user_id]) rescue []))
    render json: @answers.map {|answer| Api::V1::AnswerSerializer.new(answer).as_json}
  end



  private

  def answer_params
    params.require(:answer).permit(:id, :state, :content, :content_url, :user_id, :answer_option_id, :question_id, :_destroy)
  end

  def find_question
    @question = Question.find(params[:question_id]) if params[:question_id]
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

end