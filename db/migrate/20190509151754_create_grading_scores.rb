class CreateGradingScores < ActiveRecord::Migration[5.1]
  def change
    create_table :grading_scores do |t|
      t.references :grading_system, foreign_key: true
      t.string :name
      t.integer :score

      t.timestamps
    end
  end
end
