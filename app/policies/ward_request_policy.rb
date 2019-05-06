class WardRequestPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    true
  end

  def show?
    admin? || (record.user == user) || (record.guardian == user)
  end

  def update?
    record.user == user
  end

  def destroy?
    show?
  end
end
