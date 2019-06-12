class Api::V1::GroupMembershipsController < Api::V1::Resources::BaseController

  private

  def group_membership_params
    params.require(:group_membership).permit(:id, :study_group_id, :user_id, :_destroy)
  end

end
