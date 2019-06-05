class AnswerOption < ApplicationRecord
  belongs_to :question, inverse_of: :answer_options
  validates :content, presence: true
end
