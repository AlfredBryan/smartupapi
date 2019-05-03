class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :answer_option, optional: true

  STATES = %w[pending submitted passed failed cancelled]

  scope :marked, -> { where(state: %w[passed failed]) }
  scope :cancelled, -> { where(state: 'cancelled') }

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
end
