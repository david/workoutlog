require "test_helper"

class TrainingSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as @user
  end

  test "should get index and redirect to today's session" do
    get training_sessions_url
    # The redirect target uses the object's to_param
    assert_redirected_to training_session_url(TrainingSession.new(session_on: Date.today))
  end

  test "should get show for today's session and redirect to first exercise" do
    # Ensure user has an exercise for the redirect to work
    assert @user.exercises.any?, "User fixture must have at least one exercise"
    first_exercise = @user.exercises.first
    today_formatted = I18n.l(Date.today, format: :ymd)

    get training_session_url(session_on: today_formatted)
    assert_redirected_to training_session_exercise_url(training_session_session_on: today_formatted, id: first_exercise)
  end

  test "should get show for today's session and redirect to new exercise if none exist" do
    # Use a user specifically created without exercises
    @no_exercises_user = users(:no_exercises_user)
    sign_in_as @no_exercises_user
    assert @no_exercises_user.exercises.empty?, "User fixture no_exercises_user must have no exercises"
    today_formatted = I18n.l(Date.today, format: :ymd)

    get training_session_url(session_on: today_formatted)
    assert_redirected_to new_training_session_exercise_path(training_session_session_on: today_formatted)
  end

  test "should get show for past session and render table" do
    past_date = Date.yesterday
    training_session = @user.training_sessions.create!(session_on: past_date)
    exercise_option = exercise_options(:one) # Push Ups - Standard
    exercise_choice = training_session.exercise_choices.create!(exercise_option: exercise_option, reps: 12)
    past_date_formatted = I18n.l(past_date, format: :ymd)

    get training_session_url(session_on: past_date_formatted)

    assert_response :success
    assert_select "main table.table", 1 # Check for the main table
    # Check for the specific choice data within a table row
    assert_select "tbody tr" do |rows|
      assert_select rows.first, "td", text: exercise_option.description
      assert_select rows.first, "td", text: exercise_choice.reps.to_s
    end
    # Ensure it doesn't render the exercise show page's lists
    assert_select "ul.list", 0
  end

  test "should redirect show for future session to today" do
    future_date = Date.tomorrow
    training_session = @user.training_sessions.create!(session_on: future_date)
    exercise_option = exercise_options(:three)
    exercise_choice = training_session.exercise_choices.create!(exercise_option: exercise_option, reps: 20)
    future_date_formatted = I18n.l(future_date, format: :ymd)

    get training_session_url(session_on: future_date_formatted)

    # The redirect target uses the object's to_param
    assert_redirected_to training_session_url(TrainingSession.new(session_on: Date.today))
  end

  test "should redirect index if not signed in" do
    https!
    reset!
    get training_sessions_url
    assert_redirected_to new_authentication_path
  end

  test "should redirect show if not signed in" do
    https!
    reset!
    # The target uses the object's to_param
    get training_session_url(TrainingSession.new(session_on: Date.today))
    assert_redirected_to new_authentication_path
  end
end
