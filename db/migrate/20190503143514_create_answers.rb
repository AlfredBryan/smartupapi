class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :answer_option, foreign_key: true
      t.string :state
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.text :content
      t.string :content_url

      t.timestamps
    end
  end
end
