class GradingScore < ApplicationRecord
  belongs_to :grading_chart

  GRADING_OPTIONS = { excellent: "A",
                     very_good: "B",
                     good: "C",
                     moderate: "D",
                     pass: "E",
                     fail: "F" }


  validates :name, presence: true, inclusion: { in: GRADING_OPTIONS.keys.map(&:to_s) }
  validates :name, uniqueness: { scope: :grading_chart_id }
end
