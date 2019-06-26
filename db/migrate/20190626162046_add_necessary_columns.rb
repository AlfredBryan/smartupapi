class AddNecessaryColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :score, :decimal, precision: 5,  scale: 2, default: 0.0
    add_column :questions, :max_score, :decimal, precision: 5,  scale: 2, default: 0.0

    add_column :questions, :question_type, :string, default: "choice"

    add_reference :answers, :assessment, index: true
  end
end
