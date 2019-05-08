class Api::V1::WardRequestsController < Api::V1::Resources::BaseController
  before_action :find_ward_request, except: [:index, :create]
  skip_before_action :load_resource, only: :create

  def index
    @ward_requests = policy_scope(WardRequest)
    render json: @ward_requests.map {|ward_request| WardRequestSerializer.new(ward_request).as_json}
  end

  def create
    @ward_request = WardRequest.new()
    @ward_request.guardian = current_user
    if @user = User.with_email(params[:email]).first
      @ward_request.user = @user
    end
    authorize(instance)
    if instance.save && instance.valid?
      render json: instance, serializer: serializer
    else
      render json: instance, serializer: serializer, status: :unprocessable_entity
    end
  end

  def approve
    authorize(@ward_request)
    @ward_request.update_column(:approved, true)
    render json: instance, serializer: serializer
  end

  private

  def ward_request_params
    params.require(:ward_request).permit(:id, :user_id, :guardian_id, :approved, :_destroy)
  end

  def find_ward_request
    @ward_request = WardRequest.find(params[:id])
  end

end
