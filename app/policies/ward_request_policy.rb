class WardRequestPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope
      elsif user.guardian?
        scope.pending.where(guardian_id: user.id)
      else
        scope.pending.where(user_id: user.id)
      end
    end
  end

  def create?
    admin? || ((user.guardian? && record.guardian == user) && record.user.guardians.exclude?(user))
  end

  def approve?
    record.user == user
  end

  def show?
    admin? || approve? || (record.guardian == user)
  end

  def destroy?
    show?
  end
end
