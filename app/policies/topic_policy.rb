class TopicPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    admin? || (record.course.creator == user) || ((record.course.institution.owner == user) rescue false)
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
