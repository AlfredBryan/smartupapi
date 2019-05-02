class Api::V1::UserSerializer < Api::V1::ApplicationSerializer
  attributes  :email, :status, :authentication_token

end
