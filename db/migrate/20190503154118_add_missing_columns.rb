class AddMissingColumns < ActiveRecord::Migration[5.1]
  def change
    create_table :ward_requests do |t|
      t.references :user, foreign_key: true
      t.integer :guardian_id
      t.boolean :approved, default: false

      t.timestamps
    end

    add_reference :courses, :creator, foreign_key: { to_table: :users }
    add_foreign_key :institutions, :users, column: :owner_id
    add_foreign_key :ward_requests, :users, column: :guardian_id
  end
end
