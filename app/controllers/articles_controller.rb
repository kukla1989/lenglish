class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: :new
  before_action :set_article, only: %i[show edit update renglish]

  def set_article
    @article = Article.find(params[:id])
  end

  def renglish; end

  def new
    @article = Article.new
  end


  def create
    @article = Article.new article_params
    @article.user = current_user
    if @article.save
      flash[:success] = "Congratulation! Article was created."
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show; end

  def index
    @articles = Article.all.paginate(page: params[:page])
  end

  def edit; end

  def update
    @article.user = current_user
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
