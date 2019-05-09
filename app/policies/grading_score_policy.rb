class GradingSystemPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    admin? || ((record.grading_system.course.creator == user) rescue false) ||
        ((record.grading_system.institution.owner == user) rescue false) ||
        ((record.grading_system.course.institution.owner == user) rescue false)
  end

  def show?
    true
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
