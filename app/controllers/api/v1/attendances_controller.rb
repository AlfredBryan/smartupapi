class Api::V1::AttendancesController < Api::V1::Resources::BaseController

  def index
    @attendances = policy_scope(Attendance.all)
    render json: @attendances.map {|attendance| Api::V1::AttendanceSerializer.new(attendance).as_json}
  end

  private

  def attendance_params
    params.require(:attendance).permit(:id, :name, :marked_on, :study_group_id, :_destroy)
  end

end
