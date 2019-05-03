class Api::V1::InstitutionSerializer < Api::V1::ApplicationSerializer
  attribute :slug, :name, :motto, :logo_url, :email, :phone
end
