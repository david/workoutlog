require "test_helper"

class ExerciseOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @exercise = exercises(:one)
    @training_session = @user.training_sessions.today

    sign_in_as(@user)
  end

  test "should get new" do
    get new_exercise_exercise_option_url(@exercise)
    assert_response :success
  end

  test "should create exercise option" do
    assert_difference("ExerciseOption.count") do
      post exercise_exercise_options_url(@exercise), params: {
        exercise_option: {
          name: "New Option",
          description: "Test description",
          reps: 10
        }
      }
    end

    assert_redirected_to exercise_url(@exercise)

    new_option = @exercise.exercise_options.last

    assert_equal "New Option", new_option.name
    assert_equal "Test description", new_option.description
    assert_equal 10, new_option.reps
  end
end
