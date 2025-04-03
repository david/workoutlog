# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.find_or_create_by!(email: "guybrush@threepwood.com")

exercise1, exercise2, exercise3, exercise4, = 1.upto(8).
  map { |n| user.exercises.find_or_create_by!(name: "Exercise #{n}") }

exercise1.exercise_options.create_with(priority: 1, reps: 300).
  find_or_create_by(name: "Generic name", description: "Exercise 1, Option S")
e1o2 = exercise1.exercise_options.create_with(priority: 2, reps: 200).
  find_or_create_by(name: "Generic name", description: "Exercise 1, Option A")
exercise1.exercise_options.create_with(priority: 3, reps: 100).
  find_or_create_by(name: "Generic name", description: "Exercise 1, Option B")
exercise1.exercise_options.create_with(priority: 4, reps: 50).
  find_or_create_by(name: "Generic name", description: "Exercise 1, Option C")
exercise1.exercise_options.create_with(priority: 5, reps: 25).
  find_or_create_by(name: "Generic name", description: "Exercise 1, Option D")

e2o1 = exercise2.exercise_options.create_with(priority: 1, reps: 300).
  find_or_create_by(name: "Generic name", description: "Exercise 2, Option A")
exercise2.exercise_options.create_with(priority: 2, reps: 200).
  find_or_create_by(name: "Generic name", description: "Exercise 2, Option B")
exercise2.exercise_options.create_with(priority: 3, reps: 100).
  find_or_create_by(name: "Generic name", description: "Exercise 2, Option C")

e3o1 = exercise3.exercise_options.create_with(priority: 1, reps: 300).
  find_or_create_by(name: "Generic name", description: "Exercise 3, Option A")
exercise3.exercise_options.create_with(priority: 2, reps: 200).
  find_or_create_by(name: "Generic name", description: "Exercise 3, Option B")

exercise4.exercise_options.create_with(priority: 1, reps: 300).
  find_or_create_by(name: "Generic name", description: "Exercise 4, Option A")
exercise4.exercise_options.create_with(priority: 2, reps: 200).
  find_or_create_by(name: "Generic name", description: "Exercise 4, Option B")
e4o3 = exercise4.exercise_options.create_with(priority: 3, reps: 100).
  find_or_create_by(name: "Generic name", description: "Exercise 4, Option C")

user.training_sessions.create_with(
  exercise_choices: [
    ExerciseChoice.new(exercise_option: e1o2, reps: 50),
    ExerciseChoice.new(exercise_option: e2o1, reps: 10),
    ExerciseChoice.new(exercise_option: e3o1, reps: 20),
    ExerciseChoice.new(exercise_option: e4o3, reps: 40)
  ],
  session_on: Date.yesterday
).find_or_create_by!(id: 1)
