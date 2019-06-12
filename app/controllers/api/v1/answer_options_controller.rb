class Api::V1::AnswerOptionsController < Api::V1::Resources::BaseController
  before_action :find_question, except: :create
  skip_before_action :load_resource, only: :destroy

  def index
    @answer_options = policy_scope((@question.answer_options rescue []))
    render json: @answer_options.map {|answer_option| Api::V1::AnswerOptionSerializer.new(answer_option).as_json}
  end

  def create
    @answer_option = AnswerOption.new(answer_option_params)
    authorize(@answer_option)
    if @answer_option.save && @answer_option.valid?
      render json: @answer_option, serializer: serializer
    else
      render json: @answer_option, serializer: serializer, status: :unprocessable_entity
    end
  end

  private

  def answer_option_params
    params.require(:answer_option).permit(:id, :rank, :content, :correct, :question_id, :_destroy)
  end

  def find_question
    @question = Question.find(params[:question_id]) if params[:question_id]
    @answer_option = @question.answer_options.find_by_id(params[:id]) if @question
  end
end