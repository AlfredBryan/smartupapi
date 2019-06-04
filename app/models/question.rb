class Question < ApplicationRecord
  belongs_to :topic

  has_many :answer_options, dependent: :destroy
  accepts_nested_attributes_for :answer_options, reject_if: :all_blank, allow_destroy: true

  has_many :answers, dependent: :destroy
  # has_many :comments, dependent: :destroy

  validates :name, :description, presence: true

end
