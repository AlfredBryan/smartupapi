class Api::V1::GroupMembershipsController < Api::V1::Resources::BaseController
  skip_before_action :load_resource, only: :create
  skip_after_action :verify_authorized, only: :create
  skip_after_action :verify_policy_scoped, only: :create


  def create
    @study_group = StudyGroup.find(group_membership_params[:study_group_id]) rescue nil
    (group_membership_params[:user_emails].split(',') rescue []).each do |email|
      if user = User.find_by_email(email.to_s) && !user.guardian?
        @study_group.group_memberships.create!(user: user)
      end
    end if @study_group
    render json: @study_group.members.map {|user| Api::V1::UserSerializer.new(user).as_json}
  end

  private

  def group_membership_params
    params.require(:group_membership).permit(:id, :study_group_id, :user_id, :user_emails, :_destroy)
  end

end
