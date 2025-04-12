require "test_helper"

class TrainingSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)

    sign_in_as @user
  end

  test "should get index and redirect to today's exercises" do
    get training_sessions_url

    assert_redirected_to exercises_url
  end

  test "should get show for past session and render the exercises table" do
    past_date = Date.yesterday
    past_date_formatted = I18n.l(past_date, format: :ymd)

    get training_session_url(session_on: past_date_formatted)

    assert_response :success
    assert_select "main table", 1
  end

  test "should redirect show for future session to today" do
    future_date = Date.tomorrow
    future_date_formatted = I18n.l(future_date, format: :ymd)

    get training_session_url(session_on: future_date_formatted)

    assert_redirected_to exercises_url
  end
end
