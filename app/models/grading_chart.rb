class GradingChart < ApplicationRecord
  belongs_to :course, optional: true
  belongs_to :institution, optional: true

  has_many :grading_scores, dependent: :destroy

  accepts_nested_attributes_for :grading_scores, reject_if: :all_blank, allow_destroy: true

  validate :course_or_institution

  private

  def course_or_institution
    errors.add(:base, "Choose either course or Institution") unless (self.course || self.institution)
  end
end
