class AddProfileAttributesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :surname, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :image_url, :string
    add_column :users, :state, :string
    add_column :users, :completed_at, :datetime
  end
end
