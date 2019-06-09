class Api::V1::InstitutionSerializer < Api::V1::ApplicationSerializer
  attributes :slug, :name, :motto, :logo, :email, :phone, :owner_id
end
