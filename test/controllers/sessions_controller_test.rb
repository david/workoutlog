require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should create session with valid token" do
    token = @user.generate_token_for(:authentication)
    get create_session_url(token:)

    assert_redirected_to root_url
    assert_equal @user.id, session[:user_id]
  end

  test "should not create session with invalid token" do
    get create_session_url(token: "invalid")

    assert_redirected_to root_url
    assert_nil session[:user_id]
  end

  test "should not create session with expired token" do
    token = @user.generate_token_for(:authentication)
    travel 1.hour # Default token expiry is less than 1 hour
    get create_session_url(token:)

    assert_redirected_to root_url
    assert_nil session[:user_id]
  end
end
