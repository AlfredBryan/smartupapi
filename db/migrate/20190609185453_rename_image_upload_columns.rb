class RenameImageUploadColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :image_url, :image
    rename_column :institutions, :logo_url, :logo
  end
end
