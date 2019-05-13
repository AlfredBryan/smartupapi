class Api::V1::CourseSerializer < Api::V1::ApplicationSerializer
  attributes :slug, :name, :description, :institution, :active, :creator, :topics
end
