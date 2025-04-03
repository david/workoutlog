class AddNameToExerciseOptions < ActiveRecord::Migration[8.0]
  def change
    add_column :exercise_options, :name, :string, null: false
  end
end
