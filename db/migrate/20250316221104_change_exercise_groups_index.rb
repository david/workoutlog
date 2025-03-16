class ChangeExerciseGroupsIndex < ActiveRecord::Migration[8.0]
  def change
    remove_index :exercise_groups, [ :name ]
  end
end
