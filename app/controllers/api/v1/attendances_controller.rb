class Api::V1::AttendancesController < Api::V1::Resources::BaseController

  def index
    @resource_scope = (StudyGroup.find(params[:group_id]).attendances rescue nil)
    @resource_scope ||= Attendance.all
    @attendances = policy_scope(@resource_scope)
    render json: @attendances.map {|attendance| Api::V1::AttendanceSerializer.new(attendance).as_json}
  end

  private

  def attendance_params
    params.require(:attendance).permit(:id, :name, :marked_on, :study_group_id, :user_id, :_destroy)
  end

end
