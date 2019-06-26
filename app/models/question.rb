class Question < ApplicationRecord
  belongs_to :topic

  has_many :answers, dependent: :destroy
  # has_many :comments, dependent: :destroy

  QUESTION_TYPES = %w(choice theory)

  has_many :answer_options, dependent: :destroy
  has_many :assessment_questions, dependent: :destroy

  validates :name, :description, presence: true
  validates :question_type, presence: true, inclusion: { in: QUESTION_TYPES }

  scope :theory, -> { where(question_type: "theory") }
  scope :choice, -> { where(question_type: "choice") }


  def theory?
    (question_type == "theory") && answer_options.none?
  end

  def choice?
    (question_type == "choice")
  end
end
