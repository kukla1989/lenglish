require "test_helper"

class HeaderTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers


  test "links without log in" do
    get root_path
    assert_select "a.nav-link[href=?]", new_article_path
    assert_select "a.nav-link[href=?]", root_path
    assert_select "a.nav-link[href=?]", articles_path
    assert_select "a.nav-link[href=?]", new_user_session_path
    assert_select "a.nav-link[href=?]", users_path
  end

  test  "links after log in" do
    sign_in users(:roma)
    get root_path
    assert_select "a.nav-link[href=?]", edit_user_registration_path
    assert_select "a.nav-link[href=?]", destroy_user_session_path
  end

end
