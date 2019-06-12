class Api::V1::AttendanceSerializer < Api::V1::ApplicationSerializer
  attributes :name, :study_group_id, :marked_on, :user_id, :attendees
end
