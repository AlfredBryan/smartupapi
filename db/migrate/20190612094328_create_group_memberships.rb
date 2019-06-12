class CreateGroupMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :group_memberships do |t|
      t.references :user, foreign_key: true
      t.references :study_group, foreign_key: true

      t.timestamps
    end

    create_table :attendance do |t|
      t.references :user, foreign_key: true
      t.references :study_group, foreign_key: true
      t.string :name
      t.datetime :marked_on, default: nil

      t.timestamps
    end

    create_table :attendance_user do |t|
      t.references :user, foreign_key: true
      t.references :attendance, foreign_key: true

      t.timestamps
    end
  end
end
