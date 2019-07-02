class Api::V1::UsersController < Api::V1::Resources::BaseController
  skip_before_action :load_resource, only: :index

  def index
    @resource_scope = (User.send(params[:user_type]) rescue User.none) if params[:user_type]
    @resource_scope ||= User.all
    @users = policy_scope(@resource_scope)
    render json: @users.map {|user| Api::V1::UserSerializer.new(user).as_json}
  end
end