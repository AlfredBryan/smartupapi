class Api::V1::UserSerializer < Api::V1::ApplicationSerializer
  attributes  :email, :status, :authentication_token,
              :first_name, :surname, :address, :phone,
              :image_url, :state, :completed_at, :full_name, :admin

end
