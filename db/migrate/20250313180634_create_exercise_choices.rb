class CreateExerciseChoices < ActiveRecord::Migration[8.0]
  def change
    create_table :exercise_choices do |t|
      t.references :exercise_option, null: false, foreign_key: true
      t.references :training_session, null: false, foreign_key: true
      t.integer :reps

      t.timestamps
    end
  end
end
