class Api::V1::UserSerializer < Api::V1::ApplicationSerializer
  attributes  :email, :status, :authentication_token,
              :first_name, :surname, :address, :phone,
              :image_url, :state, :full_name, :admin,
              :sex, :level, :age, :completed_at
end
