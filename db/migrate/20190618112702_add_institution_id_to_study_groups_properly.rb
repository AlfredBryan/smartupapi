class AddInstitutionIdToStudyGroupsProperly < ActiveRecord::Migration[5.2]
  def change
    remove_reference :study_groups, :institutions, index: true, foreign_key: true
    add_reference :study_groups, :institution, foreign_key: true
  end
end
