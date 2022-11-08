require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "article.create_translated_article('uk') should create translated"\
                                              " article to ukraine language" do
    article = articles(:roma)
    article.create_translated_article("uk")
    assert_equal "деякого змісту. Наполегливість - це ключ.",
                 article.translated_articles.last.translated
  end
end
