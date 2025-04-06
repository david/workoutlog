require "test_helper"

class AuthenticationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new when not signed in" do
    get new_authentication_url
    assert_response :success
  end

  test "should redirect new when signed in" do
    sign_in_as @user
    get new_authentication_url
    assert_redirected_to root_url
  end

  test "should create authentication and send email for new user" do
    assert_difference("User.count") do
      assert_emails 1 do
        post authentication_url, params: { authentication: { email: "new@example.com" }, commit: I18n.t("authentications.new.login") }
      end
    end

    assert_redirected_to authentication_url
    assert_equal "new@example.com", User.last.email
  end

  test "should create authentication and send email for existing user" do
    assert_no_difference("User.count") do
      assert_emails 1 do
        post authentication_url, params: { authentication: { email: @user.email }, commit: I18n.t("authentications.new.login") }
      end
    end

    assert_redirected_to authentication_url
  end

  test "should redirect create when honeypot name field is filled" do
    assert_no_difference("User.count") do
      assert_no_emails do
        post authentication_url, params: { authentication: { email: @user.email }, name: "spam", commit: I18n.t("authentications.new.login") }
      end
    end

    assert_redirected_to authentication_url
  end

  test "should redirect create when honeypot commit field is wrong" do
    assert_no_difference("User.count") do
      assert_no_emails do
        post authentication_url, params: { authentication: { email: @user.email }, commit: "Wrong Button" }
      end
    end

    assert_redirected_to authentication_url
  end

  test "should show authentication when not signed in" do
    get authentication_url
    assert_response :success
  end

  test "should redirect show when signed in" do
    sign_in_as @user
    get authentication_url
    assert_redirected_to root_url
  end
end
