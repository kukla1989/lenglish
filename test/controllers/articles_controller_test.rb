require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
    sign_in(users(:roma))
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

    assert_redirected_to article_url(Article.first)
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
    patch article_url(@article), params: { article: { content: @article.content, title: "title" } }
    assert_equal "title", @article.reload.title
    assert_redirected_to article_path(@article)
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

  test "article title length should be less then 101 symbols" do
    title = "a" * 101
    assert_no_difference 'Article.count' do
      post articles_path, params: {article: {title: title, content: "content"}}
    end
  end

  test "article content length should be less then 10 001 symbols" do
    content = "a" * 10001
    assert_no_difference 'Article.count' do
      post articles_path, params: {article: {title: "title", content: content}}
    end
  end

  test "should show successful alert after create article" do
    post articles_path, params: {article: {title: "title",content: "some content"}}
    follow_redirect!
    assert_equal "Congratulation! Article was created.", flash[:success]
  end


end


