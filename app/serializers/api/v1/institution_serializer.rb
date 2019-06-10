class Api::V1::InstitutionSerializer < Api::V1::ApplicationSerializer
  attributes :slug, :name, :motto, :logo_url, :email, :phone, :owner_id

  def logo_url
    self.logo.url
  end
end
