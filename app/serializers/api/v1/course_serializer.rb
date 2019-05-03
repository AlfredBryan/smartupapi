class Api::V1::CourseSerializer < Api::V1::ApplicationSerializer
  attribute :slug, :name, :description, :logo_url, :institution_id, :active, :creator_id
end
