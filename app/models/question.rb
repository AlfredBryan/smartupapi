class Question < ApplicationRecord
  belongs_to :topic

  has_many :answers, dependent: :destroy
  # has_many :comments, dependent: :destroy

  has_many :answer_options, dependent: :destroy
  # accepts_nested_attributes_for :answer_options, reject_if: :all_blank, allow_destroy: true

  validates :name, :description, presence: true

end
