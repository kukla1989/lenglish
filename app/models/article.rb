class Article < ApplicationRecord
  has_many :translated_articles, dependent: :destroy
  belongs_to :user
  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true, length: {maximum: 10000}
  default_scope -> { order(created_at: :desc)}
  after_create :create_translated_article


  def create_translated_article(language = user.language)
    client = Aws::Translate::Client.new
    resp = client.translate_text({
                                   text: self.content, # required
                                   source_language_code: "en", # required
                                   target_language_code: language[-2..-1], # required
                                 })
    TranslatedArticle.create(article: self, translated: resp.translated_text,
                             language: language)
  end
end
