class CreateAssessments < ActiveRecord::Migration[5.1]
  def change
    create_table :assessments do |t|
      t.references :course, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
    add_reference :questions, :assessments, foreign_key: true
  end
end
