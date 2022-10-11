class ArticlesController < ApplicationController

  def renglish
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end


  def create
    @article = Article.new article_params
    if @article.save
      client = Aws::Translate::Client.new
      resp = client.translate_text({
                                     text: @article.content, # required
                                     source_language_code: "en", # required
                                     target_language_code: "ru", # required
                                   })
      TranslatedArticle.create(article: @article, translated: resp.translated_text,
                               language: "en")
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all.paginate(page: params[:page])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "article was destroed"
    redirect_to root_url, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
