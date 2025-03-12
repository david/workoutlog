class CreateExerciseOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_options do |t|
      t.references :exercise_group, null: false, foreign_key: true
      t.integer :priority
      t.string :description
      t.integer :reps

      t.timestamps
    end

    add_index :exercise_options, [ :exercise_group_id, :priority ], unique: true
  end
end
