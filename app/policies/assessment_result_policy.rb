class AssessmentResultPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope
      elsif user.educator?
        scope.where(assessment_id: record.assessment_id)
      else
        scope.where(user_id: user_id)
      end
    end
  end

  def create?
    admin? || user.educator?
  end

  def show?
    admin? || user.educator? || (record.user == user) || user.wards.include?(record.user)
  end

  def update?
    create? && !record.closed?
  end

  def destroy?
    update?
  end
end
