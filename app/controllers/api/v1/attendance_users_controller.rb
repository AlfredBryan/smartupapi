class Api::V1::AttendanceUsersController < Api::V1::Resources::BaseController

  private

  def attendance_user_params
    params.require(:attendance_user).permit(:id, :attendance_id, :user_id, :_destroy)
  end

end
