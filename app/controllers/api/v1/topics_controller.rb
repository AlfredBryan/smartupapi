class Api::V1::TopicsController < Api::V1::Resources::BaseController
  before_action :find_course
  before_action :find_topic, except: [:index, :create]
  skip_before_action :load_resource, only: [:create, :import_data]

  def index
    @topics = policy_scope((@course.topics rescue Topic.none))
    render json: @topics.map {|topic| Api::V1::TopicSerializer.new(topic).as_json}
  end

  def create
    @topic = @course.topics.new(topic_params)
    super
  end

  def import_data
    Topic.import(params[:csv_file].tempfile, @course)
    head :ok
  end

  private

  def topic_params
    params.require(:topic).permit(:id, :name, :description, :rank, :course_id, :active, :lecture_type, :video_url, :_destroy)
  end

  def find_course
    @course = Course.friendly.find(params[:course_slug])
  end

  def find_topic
    @topic = @course.topics.find(params[:id])
  end

end