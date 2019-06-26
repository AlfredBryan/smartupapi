class AssessmentResult < ApplicationRecord
  belongs_to :assessment
  belongs_to :user

  STATUSES = %w(started completed)

  STATUSES.each do |state|
    define_method "#{state}?" do
      self.status == state
    end
  end

  validates :status, presence: true, inclusion: { in: STATUSES }

  def answers
    user.answers.where(question_id: assessment.question_ids)
  end

  def choice_score
    ((choice_pct.to_f/assessment.questions.choice.count)*answers.choice.passed.count).round
  end

  def choice_pct
    (100 - theory_pct).abs
  end

  def theory_pct
    (100 - answers.theory.collect(&:max_score).sum).abs
  end

  def theory_score
    answers.theory.sum(:score)
  end

  def total_score
    choice_score + theory_score
  end

  def completed?
    assessment.questions.count == answers.marked.count
  end

  def mark!
    answers.each(&:mark!)
    update_score!
    if answers.marked == answers.count
      complete!
    end
  end

  def complete!
    update_column(:status, 'completed')
  end

  def update_score!
    update_column(:score, total_score)
  end
end
