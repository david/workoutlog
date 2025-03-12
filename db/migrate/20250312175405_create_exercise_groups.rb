class CreateExerciseGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_groups do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :exercise_groups, [ :name ], unique: true
  end
end
