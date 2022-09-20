require "test_helper"

class ArticlesIndexTest < ActionDispatch::IntegrationTest
  def setup
    get articles_path
  end


  test "links paginated pages should appear" do
    assert_template "articles/index"
    assert_select "div.pagination"
    assert_match "1", response.body
  end


  test "display first 30 articles on first page" do
     Article.all.paginate(page: 1).each do |article|
       assert_select "h3", article.title
       assert_select "p", article.content
     end
  end
end
