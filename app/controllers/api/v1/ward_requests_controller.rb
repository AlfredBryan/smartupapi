class Api::V1::WardRequestsController < Api::V1::Resources::BaseController
  before_action :find_ward_request, except: :index

  def index
    @ward_requests = policy_scope(WardRequest)
    respond_to do |format|
      format.json {
        render json: @ward_requests.map {|ward_request| WardRequestSerializer.new(ward_request).as_json}
      }
    end
  end

  def create
    @ward_request.guardian = current_user
    if @user = User.with_email(ward_request_params[:email]).first
      @ward_request.user = @user
    end
    super
  end

  def toggle
    authorize(@ward_request)
    @ward_request.update_column(:approved, !@ward_request.approved?)
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
