class AnswerOptionPolicy < ApplicationPolicy
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

  def update?
    create?
  end

  def destroy?
    puts "#####################"
    puts "#####################"
    puts record
    puts Answer.where(answer_option_id: record.id).none?
    puts "#####################"
    puts "#####################"
    create? && Answer.where(answer_option_id: record.id).none?
  end
end
