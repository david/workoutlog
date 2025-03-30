# frozen_string_literal: true

class RenameExerciseGroupToExercise < ActiveRecord::Migration[8.0]
  def change
    rename_table :exercise_groups, :exercises

    rename_column :exercise_options, :exercise_group_id, :exercise_id
  end
end
