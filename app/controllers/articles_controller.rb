class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit update destroy]
  before_action :set_article, only: %i[show edit update destroy renglish]
  before_action :correct_user, only: %i[edit update, destroy]



  def renglish
    translated_articles = @article.translated_articles
    @translated = translated_articles.first.translated
    if current_user
      unless translated_articles.first.language == current_user.language
        tmp = false
        translated_articles.each do |t_article|
          if t_article.language == current_user.language
            @translated = t_article.translated
            tmp = true
            break
          end
        end
        unless tmp
          @article.create_translated_article(current_user.language)
          @translated = @article.translated_articles.reload.last.translated
        end
      end
    else
      flash[:alert] = "if you want choose you language for translated sentences "\
                         "please sign in and choose it in settings"
    end
  end

  def user_articles
    if params[:subject]
      @articles = Article.where(user_id: params[:id]).where(subject: params[:subject]).paginate(page: params[:page])
    else  
      @articles = Article.where(user_id: params[:id]).paginate(page: params[:page])
    end
  end


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
    if params[:subject]
      
      @articles = Article.where(subject: params[:subject]).paginate(page: params[:page])
    else  
      @articles = Article.all.paginate(page: params[:page])
    end  
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
    @article.destroy
    flash[:success] = "article was destroed"
    redirect_to root_url, status: :see_other
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :subject)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def correct_user
    if !(current_user.admin)
      unless current_user && current_user == @article.user
        flash[:alert] = "You dont have permission to do this! Please log in"\
          "or create your own article!"

        redirect_to new_user_session_path
      end
    end
  end
end

