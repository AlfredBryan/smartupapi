class Api::V1::WardRequestSerializer < Api::V1::ApplicationSerializer
  attributes :user, :guardian, :approved

end
