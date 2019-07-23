class Course < ApplicationRecord
  belongs_to :institution, optional: true
  belongs_to :creator, class_name: 'User'

  has_many :topics, dependent: :destroy
  has_many :assessments, dependent: :destroy
  has_many :questions, through: :topics

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :description, presence: true


  def self.import(file, creator_id, institution=nil)
    CSV.foreach(file.path, headers: true) do |row|
      course_hash = {}
      course_hash[:creator_id] = creator_id
      course_hash[:institution_id] = institution.id if institution
      row.to_hash.each_pair do |k,v|
        course_hash.merge!({k.to_s.downcase.to_sym => v}) if Course.new.attributes.keys.include?(k.downcase.to_s)
      end
      Course.create!(course_hash)
    end
  end

end
