class Api::V1::StudyGroupSerializer < Api::V1::ApplicationSerializer
  attributes :name, :level, :members, :memberships

  def memberships
    ActiveModel::SerializableResource.new(object.group_memberships,  each_serializer: Api::V1::GroupMembershipSerializer)
  end
end
