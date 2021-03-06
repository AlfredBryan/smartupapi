class Api::V1::QuestionsController < Api::V1::Resources::BaseController
  skip_before_action :load_resource, only: :import_data
  skip_after_action :verify_authorized, only: :import_data
  skip_after_action :verify_policy_scoped, only: :import_data

  def index
    @course = Course.friendly.find(params[:course_slug]) if params[:course_slug]
    @questions = policy_scope((@course.questions rescue nil) || Question.all)
    render json: @questions.map {|question| Api::V1::QuestionSerializer.new(question).as_json}
  end

  def import_data
    @topic = (Topic.find(params[:topic_id]) rescue nil)
    Question.import(params[:csv_file].tempfile, @topic)
    head :ok
  end

  def set_score
    @question = (Question.find(params[:id]) rescue nil)
    if @question
      authorize(@question)
      max_score = @question.maximum_scores.where(assessment_id: params[:assessment_id]).first_or_create
      max_score.update_attributes(score: params[:score])
    end
    render json: max_score, serializer: Api::V1::MaximumScoreSerializer
  end

  private

  def question_params
    params.require(:question).permit(:id, :name, :description, :topic_id, :question_type, :_destroy)
  end
end
