require "test_helper"

class Admin < ActionDispatch::IntegrationTest
end

class AdminTest < Admin
  test "without sign in user cant go to new article" do
    get new_article_path
  end
end
