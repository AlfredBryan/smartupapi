class AssessmentPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.student?
        scope.where.not(id: user.assessment_results.pluck(:assessment_id).flatten)
      else
        scope
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
