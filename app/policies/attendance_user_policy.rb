class AttendanceUserPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def create?
    admin? || (record.attendance.user == user)
  end

  def destroy?
    create?
  end
end
