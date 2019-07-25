class AddDefaultLectureType < ActiveRecord::Migration[5.2]
  def change
    change_column :topics, :lecture_type, :string, default: "text"
  end
end
