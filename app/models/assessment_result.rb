class AssessmentResult < ApplicationRecord
  belongs_to :assessment
  belongs_to :user

  STATUS = %w(started closed)

  STATES.each do |state|
    define_method "#{state}?" do
      self.status == state
    end
  end

  def current_score
    passed = user.answers.where(question_id: assessment.question_ids).passed
   (passed.count.to_f/assessment.questions.count)*100
  end

  def completed?
    assessment.questions.count == assessment.answers.marked.where(user_id: user.id).count
  end

  def update_score!
    update_column(:score, current_score)
  end
end
