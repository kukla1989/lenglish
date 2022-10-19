require "test_helper"

class HeaderTest < ActionDispatch::IntegrationTest


  test "links without log in" do
    get root_path
    assert_select "a.nav-link[href=?]", root_path
    assert_select "a.nav-link[href=?]", new_user_session_path
    assert_select "a.nav-link[href=?]", users_path
    assert_select "a.nav-link[href=?]", edit_user_registration_path, count: 0
    assert_select "a.nav-link[href=?]", destroy_user_session_path, count: 0
    assert_select "a.nav-link[href=?]", new_article_path, count: 0
  end

  test  "links after log in" do
    sign_in users(:roma)
    get root_path
    assert_select "a.nav-link[href=?]", edit_user_registration_path
    assert_select "a.nav-link[href=?]", destroy_user_session_path
    assert_select "a.nav-link[href=?]", new_article_path
    assert_select "a.nav-link[href=?]", new_user_session_path, count: 0
  end

end
