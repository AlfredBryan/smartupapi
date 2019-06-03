class Topic < ApplicationRecord
  belongs_to :course

  has_many :questions, dependent: :destroy

  LECTURE_TYPES = %w(text video)

  LECTURE_TYPES.each do |type|
    define_method "#{type}?" do
      self.lecture_type == type
    end
  end

  validates :lecture_type, presence: true
  validates :description, presence: true, if: :text?
  validates :video_url, presence: true, if: :video?

  def questions_with_answers
    questions.order(:rank).includes(:answers)
  end
end
