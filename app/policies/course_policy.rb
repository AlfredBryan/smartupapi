class CoursePolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    admin? || (record.institution.owner == user) || record.educator?
  end

  def show?
    true
  end

  def update?
    create? || (record.creator == user)
  end

  def destroy?
    update?
  end
end
