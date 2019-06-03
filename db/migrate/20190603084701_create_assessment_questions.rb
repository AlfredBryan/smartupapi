class CreateAssessmentQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :assessment_questions do |t|
      t.integer :assessment_id
      t.integer :question_id

      t.timestamps
    end
    add_index :assessment_questions, [:assessment_id, :question_id]
  end
end
