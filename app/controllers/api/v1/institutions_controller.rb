class Api::V1::InstitutionsController < Api::V1::Resources::BaseController
  before_action :find_institution, except: :index

  def index
    @institutions = policy_scope(Institution)
    respond_to do |format|
      format.json {
        render json: @institutions.map {|institution| InstitutionSerializer.new(institution).as_json}
      }
    end
  end

  private

  def institution_params
    params.require(:institution).permit(:id, :name, :motto, :logo_url, :email, :phone, :_destroy)
  end

  def find_institution
    @institution = Institution.friendly.find(params[:id])
  end

end