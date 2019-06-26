class CreateAssessmentResults < ActiveRecord::Migration[5.2]
  def change
    create_table :assessment_results do |t|
      t.references :user, foreign_key: true
      t.references :assessment, foreign_key: true
      t.decimal :score, precision: 5,  scale: 2, default: 0.0
      t.string :status, default: "started"

      t.timestamps
    end
  end
end
