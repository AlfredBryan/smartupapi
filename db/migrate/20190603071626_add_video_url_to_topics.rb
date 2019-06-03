class AddVideoUrlToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :video_url, :string
  end
end
