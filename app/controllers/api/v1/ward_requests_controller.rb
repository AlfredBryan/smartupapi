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

  private

  def ward_request_params
    params.require(:ward_request).permit(:id, :user_id, :guardian_id, :approved, :_destroy)
  end

  def find_ward_request
    @assessment = Course.friendly.find(params[:id])
  end

end
