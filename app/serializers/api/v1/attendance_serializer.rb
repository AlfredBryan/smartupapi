class Api::V1::AttendanceSerializer < Api::V1::ApplicationSerializer
  attributes :name, :study_group_id, :marked_on, :user_id, :attendees, :attendance_users

  def attendance_users
    ActiveModel::SerializableResource.new(object.attendance_users,  each_serializer: Api::V1::AttendanceUserSerializer)
  end
end
