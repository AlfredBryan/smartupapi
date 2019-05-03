class Api::V1::SessionsController < Api::V1::BaseController
  before_action :authenticate_with_token!, except: [:create]

  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  respond_to :json

  def create
    if user = find_resource
      sign_in(:user, user)
      render json: Api::V1::UserSerializer.new(user, root:false).to_json, status: :created
    else
      head :unauthorized
    end
  end

  def forgot_password
    resource = User.with_email(params[:email]).first
    Api::V1::CustomDeviseMailer.reset_password_instructions(  resource, token).deliver
    head :ok
  end

  def reset_password
    digested_token = Devise.token_generator.digest(nil, :reset_password_token, params[:token])
    resource = User.find_by_reset_password_token(digested_token)

    if resource.present?
      resource.authentication_token = nil
      resource.reset_password!(params[:password], params[:password_confirmation])
      render json: resource
    else
      raise ActiveRecord::RecordNotFound.new()
    end
  end

  def destroy
    current_user.reset_authentication_token!
    head :ok
  end

  private

  def find_resource
    User.with_email(params[:email]).detect{|usr| usr.valid_password?(params[:password]) }
  end

  def set_serializer_namespace
    self.namespace_for_serializer = 'Api::V1'
  end
end
