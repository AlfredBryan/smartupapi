class GroupMembershipPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    (admin? || ((record.study_group.institution.owner == user) rescue false)) && !record.user.guardian?
  end

  def destroy?
    create?
  end
end

