class Api::V1::CoursesController < Api::V1::Resources::BaseController
  before_action :find_course, except: :index

  def index
    @institution = Institution.friendly.find(params[:institution_id]) if params[:institution_id]
    @resource_scope = @institution.courses if @institution
    @resource_scope ||= Course.all
    @courses = policy_scope(@resource_scope)
    render json: @courses.map {|course| Api::V1::CourseSerializer.new(course).as_json}
  end

  def create
    @course.creator = current_user
    super
  end

  private

  def course_params
    params.require(:course).permit(:id, :name, :description, :logo_url, :institution_id, :active, :creator_id, :_destroy)
  end

  def find_course
    @course = Course.friendly.find(params[:id])
  end

end
