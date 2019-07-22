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

  def self.import(file, course=nil)
    file = Base64.decode64(file).tempfile
    CSV.foreach(file.path, headers: true) do |row|
      topic_hash = {}
      topic_hash[:course_id] = course.id if course
      row.to_hash.each_pair do |k,v|
        topic_hash.merge!({k.to_s.downcase.to_sym => v}) if Topic.new.attributes.keys.include?(k.downcase.to_s)
      end
      Topic.create!(topic_hash)
    end
  end
end
