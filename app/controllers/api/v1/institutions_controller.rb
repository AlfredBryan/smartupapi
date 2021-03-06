class Api::V1::InstitutionsController < Api::V1::Resources::BaseController
  before_action :find_institution, except: [:index, :create]
  skip_before_action :load_resource, except: :create

  def index
    @institutions = policy_scope(Institution.all)
    render json: @institutions.map {|institution| Api::V1::InstitutionSerializer.new(institution).as_json}
  end

  def create
    @institution.owner = current_user
    super
  end

  private

  def institution_params
    params.require(:institution).permit(:id, :name, :motto, :logo, :email, :phone, :_destroy)
  end

  def find_institution
    @institution = Institution.friendly.find(params[:id])
  end

end
