class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :name
      t.references :course, foreign_key: true
      t.integer :rank
      t.boolean :active, default: false
      t.text :description

      t.timestamps
    end
  end
end
