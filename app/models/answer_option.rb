class AnswerOption < ApplicationRecord
  belongs_to :question, inverse_of: :answer_question
  validates :content, presence: true
end
