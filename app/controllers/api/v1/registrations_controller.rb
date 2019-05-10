class Api::V1::RegistrationsController < Api::V1::BaseController
  before_action :authenticate_with_token!, except: :create

  respond_to :json

  def create
    @user = User.new(sign_up_params)

    if @user.save && @user.valid?
      render(json: Api::V1::UserSerializer.new(@user).to_h.merge(status: 200))
    else
      render(json: Api::V1::UserSerializer.new(@user).to_h.merge(status: 400))
    end
  end

  def family
    render json: current_user.send(current_user.guardian? ? :wards : :guardians).map {|user| Api::V1::UserSerializer.new(user).as_json}
  end

  def update
    @user = current_user
    if @user.update_attributes(profile_params) && @user.valid?
      render(json: Api::V1::UserSerializer.new(@user).to_h.merge(status: 200))
    else
      render(json: Api::V1::UserSerializer.new(@user).to_h.merge(status: 400))
    end
  end

  def destroy
    resource = current_user
    resource.destroy
    head :ok
  end


  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :status)
  end

  def profile_params
    params.require(:user).permit(:first_name, :surname, :address, :phone, :image_url, :state, :sex, :level, :date_of_birth)
  end

end
