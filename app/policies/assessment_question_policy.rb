class AssessmentQuestionPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope
      else
        scope.where(assessment_id: record.assessment_id)
      end
    end
  end

  def create?
    admin? || user.educator?
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
