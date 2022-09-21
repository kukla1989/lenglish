require "test_helper"

class ArticlesShowTest < ActionDispatch::IntegrationTest
  def setup
    @article = articles(:one)
  end


  test "should display content and title" do
    get article_path(@article)
    assert_select "h3", @article.title
    assert_select "p", @article.content
  end


  test "link to edit end delete" do
    get article_path @article
    assert_select "a", "edit"
    assert_select "button", "delete"
  end
end
