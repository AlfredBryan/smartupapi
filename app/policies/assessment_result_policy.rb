class AssessmentResultPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin? || user.educator?
        scope
      else
        scope.where(user_id: user.id)
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
    create? && !record.completed?
  end

  def destroy?
    update?
  end
end
