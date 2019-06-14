class AddInstitutionToStudyGroup < ActiveRecord::Migration[5.2]
  def change
    add_reference :study_groups, :institutions, foreign_key: true
  end
end
