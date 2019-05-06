class Api::V1::WardRequestSerializer < Api::V1::ApplicationSerializer
  attributes :user_id, :guardian_id, :approved

end
