class InstitutionPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    admin? || user.educator?
  end

  def show?
    true
  end

  def update?
    create? || (record.owner == user)
  end

  def destroy?
    admin?
  end
end
