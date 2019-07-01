class UserPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope
      elsif user.educator?
        scope.where(id: user.group_memberships.pluck(:user_id).flatten)
      elsif user.guardian?
        scope.where(id: user.ward_ids)
      else
        scope.where(id: user.guardian_ids)
      end
    end
  end

  def show?
    true
  end

  def update?
    admin? || (user == record)
  end

  def destroy?
    update?
  end
end
