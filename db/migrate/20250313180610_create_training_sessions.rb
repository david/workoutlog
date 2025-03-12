class CreateTrainingSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :training_sessions do |t|
      t.date :session_on

      t.timestamps
    end
  end
end
