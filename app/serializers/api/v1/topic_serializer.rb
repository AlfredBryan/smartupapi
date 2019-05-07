class Api::V1::TopicSerializer < Api::V1::ApplicationSerializer
  attributes :name, :description, :rank, :course_id, :active
end
