class GroupMembershipPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    admin? || user.educator?
  end

  def destroy?
    create?
  end
end

