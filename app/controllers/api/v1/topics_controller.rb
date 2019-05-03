class Api::V1::TopicsController < Api::V1::Resources::BaseController
  before_action :find_topic, except: :index

  def index
    @course = Course.friendly.find(params[:course_slug])
    @topics = policy_scope((@course.topics rescue Topic.none))
    respond_to do |format|
      format.json {
        render json: @topics.map {|topic| TopicSerializer.new(topic).as_json}
      }
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:id, :name, :description, :rank, :course_id, :active, :_destroy)
  end

  def find_topic
    @course = Course.friendly.find(params[:course_slug])
    @topic = @course.topics.find(params[:id])
  end

end