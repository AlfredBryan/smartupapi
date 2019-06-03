class AddLectureTypeToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :lecture_type, :string
  end
end
