class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :assessment_question
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

  def update_score!
    result = self.user.assessment_results.where(assessment_id: assessment_question.assessment_id).first_or_create
    result.update_score!
  end
end
