class Api::V1::CoursesController < Api::V1::Resources::BaseController
  before_action :find_course, except: [:index, :create]

  def index
    @institution = Institution.friendly.find(params[:institution_id]) if params[:institution_id]
    @courses = policy_scope((@institution.courses rescue nil) || Course.all)
    render json: @courses.map {|course| Api::V1::CourseSerializer.new(course).as_json}
  end

  def create
    @course.creator = current_user
    super
  end

  private

  def course_params
    params.require(:course).permit(:id, :name, :description, :institution_id, :active, :creator_id, :_destroy)
  end

  def find_course
    @course = Course.friendly.find(params[:id])
  end

end
