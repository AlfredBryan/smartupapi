class Api::V1::AnswerOptionsController < Api::V1::Resources::BaseController
  before_action :find_answer_option, except: [:index, :create]
  before_action :find_question

  def index
    @answer_options = policy_scope((@question.answer_options rescue []))
    render json: @answer_options.map {|answer_option| Api::V1::AnswerOptionSerializer.new(answer_option).as_json}
  end

  private

  def answer_option_params
    params.require(:answer_option).permit(:id, :rank, :content, :correct, :question_id, :_destroy)
  end

  def find_question
    @question = Question.find(params[:question_id]) if params[:question_id]
  end

  def find_answer_option
    @answer_option = (@question.answer_options.find_by_id(params[:id]) rescue nil)
  end

end