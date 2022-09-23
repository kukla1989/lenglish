require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: { article: { content: @article.content, title: @article.title } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { content: @article.content, title: @article.title } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end
    assert_redirected_to root_url
  end

  test "article content should not be blank" do
    assert_no_difference 'Article.count' do
      post articles_path, params: {article: {title: "some title",content: ""}}
    end
  end

  test "article title should not be blank" do
    assert_no_difference 'Article.count' do
      post articles_path, params: {article: {title: "",content: "some content"}}
    end
  end

  test "article title length should be less then 31 symbols" do
    title = "a" * 31
    assert_no_difference 'Article.count' do
      post articles_path, params: {article: {title: title, content: "content"}}
    end
  end

  test "article content length should be less then 2 001 symbols" do
    content = "a" * 2002
    assert_no_difference 'Article.count' do
      post articles_path, params: {article: {title: "title", content: content}}
    end
  end
end


