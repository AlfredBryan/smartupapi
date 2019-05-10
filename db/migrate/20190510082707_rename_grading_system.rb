class RenameGradingSystem < ActiveRecord::Migration[5.1]
  def up
    if ActiveRecord::Base.connection.table_exists? :grading_systems
      rename_table :grading_systems, :grading_charts
      rename_column :grading_scores, :grading_system_id, :grading_chart_id
    end
  end

  def down
    if ActiveRecord::Base.connection.table_exists? :grading_charts
      rename_table :grading_charts, :grading_systems
      rename_column :grading_scores, :grading_chart_id, :grading_system_id
    end
  end
end
