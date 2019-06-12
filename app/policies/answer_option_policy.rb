class AnswerOptionPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope
      else
        scope.where(question_id: record.question_id)
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
    create? && Answer.where(answer_option_id: record.id).none?
  end
end
