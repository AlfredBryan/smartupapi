class Bulk::CourseUpload

  attr_accessor :file, :creator, :institution

  def initialize(file, creator, institution=nil)
    @file = file
    @creator = creator
    @institution = institution
  end

  def import!
    CSV.parse(file.path, headers: true) do |row|
      course_hash = {}
      course_hash[:creator_id] = creator.id if creator
      course_hash[:institution_id] = institution.id if institution
      row.to_hash.each_pair do |k,v|
        course_hash.merge!({k.to_s.downcase.to_sym => v}) if Course.new.attributes.keys.include?(k.downcase.to_s)
      end
      Course.create!(course_hash)
    end
  end
end