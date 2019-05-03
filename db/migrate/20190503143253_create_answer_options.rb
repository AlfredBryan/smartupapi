class CreateAnswerOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :answer_options do |t|
      t.references :question, foreign_key: true
      t.integer :rank
      t.text :content
      t.boolean :correct, default: false

      t.timestamps
    end
  end
end
