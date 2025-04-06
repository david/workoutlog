require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @exercise = exercises(:one)
    sign_in_as @user
  end

  test "should get show for today's session" do
    assert @user.exercises.any?, "User fixture must have at least one exercise"

    first_exercise = @user.exercises.first
    today_formatted = I18n.l(Date.today, format: :ymd)

    get training_session_url(session_on: today_formatted)

    assert_redirected_to training_session_exercise_url(training_session_session_on: today_formatted, id: first_exercise)
    follow_redirect!

    assert_response :success
    assert_select "li a[href=?]", training_session_exercise_path(training_session_session_on: today_formatted, id: first_exercise), text: first_exercise.name
  end

  test "should get show for a past session" do
    past_date = Date.yesterday
    training_session = @user.training_sessions.create!(session_on: past_date)
    exercise_option = exercise_options(:one)
    training_session.exercise_choices.create!(exercise_option:, reps: 10)
    past_date_formatted = I18n.l(past_date, format: :ymd)

    get training_session_exercise_url(training_session_session_on: past_date_formatted, id: @exercise)

    assert_response :success
    assert_select "li a[href=?]", training_session_exercise_path(training_session_session_on: past_date_formatted, id: @exercise), text: @exercise.name
    assert_select "ul.list", count: 2
  end

  test "should redirect if not signed in" do
    https!
    reset!

    get training_session_exercise_url(training_session_session_on: I18n.l(Date.today, format: :ymd), id: @exercise)

    assert_redirected_to new_authentication_path
  end

  test "should redirect show for future session" do
    future_date = Date.tomorrow
    future_date_formatted = I18n.l(future_date, format: :ymd)

    get training_session_exercise_url(training_session_session_on: future_date_formatted, id: @exercise)

    assert_redirected_to training_session_url(TrainingSession.new(session_on: Date.today))
  end
end
