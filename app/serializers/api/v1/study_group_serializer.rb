class Api::V1::StudyGroupSerializer < Api::V1::ApplicationSerializer
  attributes :name, :level, :members, :memberships, :owner_id

  def owner_id
    object.institution.owner_id
  end

  def memberships
    ActiveModel::SerializableResource.new(object.group_memberships,  each_serializer: Api::V1::GroupMembershipSerializer)
  end
end
