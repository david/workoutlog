require "test_helper"

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @exercise = exercises(:one)

    sign_in_as @user
  end

  test "should get index for today's session" do
    get exercises_url
    assert_response :success
    assert_select "ul li a[href=?]", exercise_path(@exercise)
    assert_select "main table", 0
  end

  test "should get show for today's session" do
    get exercise_url(@exercise)

    assert_response :success
    assert_select "li a[href=?]", exercise_path(@exercise), text: @exercise.name
    assert_select "form[action=?]", exercise_choices_path
  end

  test "should get show for a past session via dated route" do
    past_date = Date.yesterday
    past_date_formatted = I18n.l(past_date, format: :ymd)

    get training_session_exercise_url(training_session_session_on: past_date_formatted, id: @exercise)

    assert_response :success
    assert_select(
      "li a[href=?]",
      training_session_exercise_path(training_session_session_on: past_date_formatted, id: @exercise),
      text: @exercise.name
    )
    assert_select "form", 0
  end

  test "should create exercise" do
    exercise_name = "New Exercise"

    assert_difference("@user.exercises.count") do
      post exercises_url, params: { exercise: { name: exercise_name } }
    end

    new_exercise = @user.exercises.find_by!(name: exercise_name)

    assert_redirected_to exercise_url(new_exercise)
  end
end
