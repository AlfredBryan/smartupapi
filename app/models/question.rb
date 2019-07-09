class Question < ApplicationRecord
  belongs_to :topic, optional: true

  has_many :answers, dependent: :destroy
  has_many :maximum_scores
  # has_many :comments, dependent: :destroy

  QUESTION_TYPES = %w(choice theory)

  has_many :answer_options, dependent: :destroy
  has_many :assessment_questions, dependent: :destroy

  validates :name, :description, presence: true
  validates :question_type, presence: true, inclusion: { in: QUESTION_TYPES }

  validate :theory_question?

  scope :theory, -> { where(question_type: "theory") }
  scope :choice, -> { where(question_type: "choice") }


  def theory?
    (question_type == "theory") && answer_options.none?
  end

  def choice?
    (question_type == "choice")
  end

  def theory_question?
    errors.add(:question_type, "Remove all answer options to make this a theory question!") if answer_options.any?
  end

  def max_score(assessment_id)
    maximum_scores.find_by(assessment_id: assessment_id).score
  rescue
    0.0
  end
end
