require "test_helper"

class ArticlesShowTest < ActionDispatch::IntegrationTest
  def setup
    @article = articles(:roma)
  end


  test "should display content, title and subject" do
    get article_path(@article)
    assert_select "h3", @article.title
    assert_select "p", @article.content
    assert_select "h5", "subject: " + @article.subject
  end


  test "link to edit end delete" do
    sign_in(users(:admin))
    get article_path @article
    assert_select "a", "edit"
    assert_select "a", "delete"
  end
end
