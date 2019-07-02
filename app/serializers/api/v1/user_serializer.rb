class Api::V1::UserSerializer < Api::V1::ApplicationSerializer
  attributes  :email, :status, :authentication_token,
              :first_name, :surname, :address, :phone,
              :image_url, :state, :full_name, :display_name, :admin,
              :sex, :level, :age, :date_of_birth, :completed_at, :total_score, :average_score

  def total_score
    object.total_score
  end

  def average_score
    object.average_score
  end

end
