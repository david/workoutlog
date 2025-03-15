class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email

      t.timestamps
    end

    add_reference :training_sessions, :user, foreign_key: true, index: true, null: false
    add_reference :exercise_groups, :user, foreign_key: true, index: true, null: false
  end
end
