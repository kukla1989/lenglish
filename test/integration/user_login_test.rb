require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  test "should get log in" do
    get new_user_session_path
    assert_response :success
    assert_template "devise/sessions/new"
  end

  test "log in with valid email password" do
    @roma = users(:roma)
    post user_session_path, params: {user: {email: @roma.email,
                                           password: 'password'}}
    assert_response :redirect
    assert_equal "Signed in successfully.", flash[:notice]
  end
end
