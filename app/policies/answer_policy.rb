class AnswerPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    true
    # record.question.assessment.course.institution.nil? || record.question.assessment.course.institution
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
