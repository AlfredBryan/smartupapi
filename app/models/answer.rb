class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :assessment
  belongs_to :question
  belongs_to :answer_option, optional: true

  STATES = %w[pending submitted passed failed cancelled]

  scope :passed, -> { where(state: "passed") }
  scope :marked, -> { where(state: %w[passed failed]) }
  scope :cancelled, -> { where(state: 'cancelled') }

  after_save :update_score! if :marked?

  STATES.each do |state|
    define_method "#{state}?" do
      self.state == state
    end
  end

  delegate :theory?, :choice?, :max_score, to: :question

  scope :theory, -> { joins(:question).where(questions: { question_type: "theory" }) }
  scope :choice, -> { joins(:question).where(questions: { question_type: "choice" }) }

  validates :state, presence: true, inclusion: { in: STATES }

  def marked?
    passed? || failed?
  end

  def submit!
    self.state = 'submitted' and save!
  end

  def pass!
    self.state = 'passed' and save!
  end

  def fail!
    self.state = 'failed' and save!
  end

  def cancel!
    self.state = 'cancelled' and save!
  end

  def mark!
    return unless answer.choice?
    answer.answer_option.correct? ? pass! : fail!
  end
end
