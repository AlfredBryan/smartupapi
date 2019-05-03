class CreateInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :motto
      t.string :logo_url
      t.string :email
      t.string :phone
      t.string :slug
      t.integer :owner_id

      t.timestamps
    end
    add_index :institutions, :slug, unique: true
  end
end
