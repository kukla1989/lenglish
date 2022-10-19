require "test_helper"

class UserArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @roma = users(:roma)
    get user_articles_article_path(@roma)
  end


  test "links paginated pages should appear" do
    assert_template "articles/user_articles"
    assert_select "span.previous_page"
    assert_match "Previous", response.body
  end


  test "display first 30 articles of author roma" do
    assert_select "a[href=?]", user_articles_article_path(@roma), "roma", count: 30
    Article.all.paginate(page: 1).each do |article|
      assert_select "h3", article.title
      assert_select "p", article.content
    end
  end
end
