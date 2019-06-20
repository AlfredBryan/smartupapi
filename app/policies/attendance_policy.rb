class AttendancePolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        scope
      elsif user.guardian?
        scope.where(study_group_id: user.wards.collect(&:study_group_ids).flatten)
      elsif user.educator?
        scope.where(user_id: user.id)
      else
        scope.where(study_group_id: user.group_memberships.pluck(:study_group_id).flatten)
      end
    end
  end

  def create?
    admin? || (((record.study_group.members.include?(user)) rescue false) && user.educator?)
  end

  def show?
    create? || record.study_group.members.include?(user) || (user.wards&record.study_group.members).any?
  end

  def update?
    admin? || record.user == user
  end

  def destroy?
    update?
  end
end
