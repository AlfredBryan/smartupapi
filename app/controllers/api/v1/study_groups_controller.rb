class Api::V1::StudyGroupsController < Api::V1::Resources::BaseController
  def index
    @study_groups = policy_scope(StudyGroup.all)
    render json: @study_groups.map {|group| Api::V1::StudyGroupSerializer.new(group).as_json}
  end

  private

  def study_group_params
    params.require(:study_group).permit(:id, :name, :level, :_destroy)
  end
end