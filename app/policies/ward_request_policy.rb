class WardRequestPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope
      elsif user.guardian?
        scope.where(guardian_id: user.id)
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def create?
    true
  end

  def approve?
    record.user == user
  end

  def show?
    admin? || toggle? || (record.guardian == user)
  end

  def destroy?
    show?
  end
end
