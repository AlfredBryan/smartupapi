class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :assessment
  belongs_to :question
  belongs_to :answer_option, optional: true

  STATES = %w[pending submitted cancelled]
  PASS_MARK = AssessmentResult::GRADES.key("E").min

  scope :passed, -> { where(state: AssessmentResult::GRADES.values[1..-1]) }
  scope :marked, -> { where(state: AssessmentResult::GRADES.values) }
  scope :unmarked, -> { where(state: STATES) }
  scope :cancelled, -> { where(state: 'cancelled') }

  after_save :submit! unless :not_ready? || :marked?

  STATES.each do |state|
    define_method "#{state}?" do
      self.state == state
    end
  end

  delegate :theory?, :choice?, :question_type, to: :question

  scope :theory, -> { joins(:question).where(questions: { question_type: "theory" }) }
  scope :choice, -> { joins(:question).where(questions: { question_type: "choice" }) }

  validates :state, presence: true, inclusion: { in: STATES + AssessmentResult::GRADES.values }
  validate :valid_score?

  def assessment_result
    user.assessment_results.find_by(assessment_id: assessment.id)
  end

  def not_ready?
    (choice? && answer_option_id.nil?) || (theory? && content.blank?)
  end

  def passed?
    AssessmentResult::GRADES.values[1..-1].include?(state)
  end

  def failed?
    AssessmentResult::GRADES.values[0] == state
  end

  def marked?
    passed? || failed?
  end

  def submit!
    self.state = 'submitted' and save!
  end

  def grade!
    grade = AssessmentResult::GRADES.select { |scores, grade| scores.include?(score.to_i) }.values.first
    self.state = grade and save!
  end

  def cancel!
    self.state = 'cancelled' and save!
  end

  def pass!
    self.state = "A" and save!
  end

  def fail!
    self.state = "F" and save!
  end

  def theory_mark!
    grade!
    assessment_result.complete!
  end

  def choice_mark!
    answer_option.correct? ? pass! : fail!
  end

  def mark!
    send("#{question_type}_mark!".to_sym)
  end

  def max_score
    question.maximum_scores.find_by(assessment_id: assessment_id).score
  rescue
    0.0
  end

  private

  def valid_score?
    errors.add(:score, "Maximum score for the question is #{max_score}") if score > max_score
  end
end
