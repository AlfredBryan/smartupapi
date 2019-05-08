class Api::V1::WardRequestsController < Api::V1::Resources::BaseController
  before_action :find_ward_request, except: :index

  def index
    @ward_requests = policy_scope(WardRequest)
    render json: @ward_requests.map {|ward_request| WardRequestSerializer.new(ward_request).as_json}
  end

  def create
    params[:ward_request][:guardian_id] = current_user.id
    if @user = User.with_email(params[:email]).first
      params[:ward_request][:user_id] = @user.id
    end
    super
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
    @assessment = Course.friendly.find(params[:id])
  end

end
