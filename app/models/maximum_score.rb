class MaximumScore < ApplicationRecord
  belongs_to :question
  belongs_to :assessment

  THRESHOLD = 60

  validate :scoring_makes_sense

  private

  def assessment_theory_total
    assessment.total_max_scores
  end

  def scoring_makes_sense
    errors.add(:score, "The scores for theory questions exceed 60%. Please reduce this or other theory questions, or remove all theory questions from assessment.") if assessment.questions.choice.any? && assessment_theory_total > 60
  end
end