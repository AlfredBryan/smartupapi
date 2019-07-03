class QuestionPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    admin? || user.educator?
  end

  def show?
    true
  end

  def set_score?
    show?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
