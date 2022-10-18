require "test_helper"

class Permission < ActionDispatch::IntegrationTest
end

class WithouSignInTest < Permission
  test "without sign in user cant go to new article" do
    get new_article_path
    assert_redirected_to new_user_session_path
    assert_response :redirect
  end

  test "without sign in user cant create article" do
    post articles_path(articles(:roma)), params: {article: {title: "new title",
                                                            content: "new content",
                                                            user_id: 1}}
    assert_response :unprocessable_entity
  end

  test "without sign in user cant go to edit article" do
    get edit_article_path(articles(:roma))
    assert_redirected_to new_user_session_path
    assert_response :redirect
  end

  test "without sign in user cant update article" do
    patch article_path(articles(:roma)), params: {article: {title: "new title"}}
    assert_redirected_to new_user_session_path
    assert_response :redirect
  end

  test "without sign in user cant create delete article" do
    delete article_path(articles(:roma))
    assert_response :redirect
    assert_redirected_to new_user_session_path

  end
end

class SignedInUserTest < Permission
  def setup
    sign_in users(:roma)
    @article_roma = articles(:roma)
  end

  test "user can open new article when signed in" do
    get new_article_path
    assert_response :success
  end

  test "user can create article when signed in" do
    assert_difference"Article.count", 1 do
      post articles_path, params: {article: {title: "some title",
                                             content: "some content"}}
    end
    follow_redirect!
    assert_template "articles/show"
    assert_response :success
  end

  test "user can go to page update of own article when signed in" do
    get edit_article_path(@article_roma)
    assert_response :success
  end

  test "user can update own article when signed in" do
    patch article_path(@article_roma), params: {article: {title: "new title"}}
    assert_response :redirect
    follow_redirect!
    assert_template "articles/show"
  end

  test "user cant update another author article" do
    patch article_path(articles(:inna)), params: {article: {title: "new title"}}
    assert_response :redirect
    assert_not_equal articles(:inna).title, "new title"
  end

  test "user can destroy own article" do
    assert_difference "Article.count", -1 do
      delete article_path(@article_roma)
    end
  end

  test "user cant destroy someone else article" do
    assert_no_difference "Article.count" do
      delete article_path(articles(:inna))
    end
  end
end

class AdminTest < Permission
  def setup
    sign_in users(:admin)
    @article_admin = articles(:admin)
  end

  test "admin can go to new article" do
    get new_article_path
    assert_response :success
  end

  test "admin can create new article" do
    assert_difference "Article.count", 1 do
      post articles_path, params: {article: {title: "some title",
                                             content: "content"}}
    end
  end

  test "admin can go to page update of own article " do
    get edit_article_path(@article_admin)
    assert_response :success
  end

  test "admin can update own article " do
    patch article_path(@article_admin), params: {article: {title: "new title"}}
    assert_response :redirect
    follow_redirect!
    assert_template "articles/show"
  end

  test "admin can update another author article" do
    patch article_path(articles(:inna)), params: {article: {title: "new title"}}
    assert_response :redirect
    assert_not_equal articles(:inna).title, "new title"
  end

  test "admin can destroy own article" do
    assert_difference "Article.count", -1 do
      delete article_path(@article_admin)
    end
  end

  test "admin can destroy someone else article" do
    assert_difference "Article.count", -1 do
      delete article_path(articles(:inna))
    end
  end
end














