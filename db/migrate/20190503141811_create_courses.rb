class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.references :institution, foreign_key: true
      t.boolean :active, default: false

      t.timestamps
    end
    add_index :courses, :slug, unique: true
  end
end
