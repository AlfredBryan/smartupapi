class RemoveMaxScoreFromQuestion < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :max_score, :decimal

    create_table :maximum_scores do |t|
      t.references :question, foreign_key: true
      t.references :assessment, foreign_key: true
      t.decimal :score, precision: 5,  scale: 2, default: 0.0

      t.timestamps
    end
  end
end
