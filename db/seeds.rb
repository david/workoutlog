# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

group1, group2, group3, group4, = 1.upto(8).map { |n| ExerciseGroup.find_or_create_by!(name: "Group #{n}") }

group1.exercise_options.create_with(priority: 1, reps: 300).
  find_or_create_by(description: "Group 1, Option S")
g1o2 = group1.exercise_options.create_with(priority: 2, reps: 200).
  find_or_create_by(description: "Group 1, Option A")
group1.exercise_options.create_with(priority: 3, reps: 100).
  find_or_create_by(description: "Group 1, Option B")
group1.exercise_options.create_with(priority: 4, reps: 50).
  find_or_create_by(description: "Group 1, Option C")
group1.exercise_options.create_with(priority: 5, reps: 25).
  find_or_create_by(description: "Group 1, Option D")

g2o1 = group2.exercise_options.create_with(priority: 1, reps: 300).
  find_or_create_by(description: "Group 2, Option A")
group2.exercise_options.create_with(priority: 2, reps: 200).
  find_or_create_by(description: "Group 2, Option B")
group2.exercise_options.create_with(priority: 3, reps: 100).
  find_or_create_by(description: "Group 2, Option C")

g3o1 = group3.exercise_options.create_with(priority: 1, reps: 300).
  find_or_create_by(description: "Group 3, Option A")
group3.exercise_options.create_with(priority: 2, reps: 200).
  find_or_create_by(description: "Group 3, Option B")

group4.exercise_options.create_with(priority: 1, reps: 300).
  find_or_create_by(description: "Group 4, Option A")
group4.exercise_options.create_with(priority: 2, reps: 200).
  find_or_create_by(description: "Group 4, Option B")
g4o3 = group4.exercise_options.create_with(priority: 3, reps: 100).
  find_or_create_by(description: "Group 4, Option C")

TrainingSession.create_with(
  exercise_choices: [
    ExerciseChoice.new(exercise_option: g1o2, reps: 50),
    ExerciseChoice.new(exercise_option: g2o1, reps: 10),
    ExerciseChoice.new(exercise_option: g3o1, reps: 20),
    ExerciseChoice.new(exercise_option: g4o3, reps: 40)
  ],
  session_on: Date.yesterday
).find_or_create_by!(id: 1)
