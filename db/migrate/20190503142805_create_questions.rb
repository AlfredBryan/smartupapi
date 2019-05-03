class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :name
      t.text :description
      t.references :topic, foreign_key: true

      t.timestamps
    end
  end
end
