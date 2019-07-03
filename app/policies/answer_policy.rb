class AnswerPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope
      elsif user.educator?
        scope.where(user_id: user.group_memberships.pluck(:user_id).flatten)
      elsif user.guardian?
        scope.where(user_id: user.ward_ids)
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def create?
    admin? || user.student?
  end

  def marking?
    admin? || user.educator?
  end

  def score?
    admin? || user.educator?
  end

  def show?
    admin? || (record.user == user) || (user.guardian? && user.wards.include?(record.user)) || (record.question.assessment.course.creator == user) || ((record.question.assessment.course.institution.owner == user) rescue false)
  end

  def update?
    record.user == user
  end

  def destroy?
    admin? || update?
  end
end
