class AssessmentPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    admin? || (record.course.creator == user) || (record.course.institution.owner == user)
  end

  def show?
    create? || (user.guardian? && user.wards.include?(record.user)) || (record.user == user)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
