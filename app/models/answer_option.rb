class AnswerOption < ApplicationRecord
  belongs_to :question, optional: true
  validates :content, presence: true
end
