class CreateGradingSystems < ActiveRecord::Migration[5.1]
  def change
    create_table :grading_systems do |t|
      t.references :course, foreign_key: true
      t.references :institution, foreign_key: true

      t.timestamps
    end
  end
end
