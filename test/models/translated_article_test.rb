require "test_helper"

class TranslatedArticleTest < ActiveSupport::TestCase

  test "translated article should automatically create after create article" do
    article = Article.create(title: "some title",
                             content: "some content. Persistence is key.",
                             user: User.first)
    translated_article = article.translated_articles.first
    assert_equal "некоторый контент. Постоянство — ключ к успеху.", translated_article.translated
    assert_equal article.id, translated_article.article_id
  end
end
