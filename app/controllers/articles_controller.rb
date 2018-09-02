class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order(created_at: 'desc').includes(:user, :favorite_articles)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_param)
    @article.user = current_user
    if @article.save
      flash[:notice] = 'saved successfully'
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_param)
      flash[:notice] = 'saved successfully'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    # @article.current_user = current_user
    if @article.destroy
      flash[:notice] = 'deleted successfully'
    else
      flash[:alert] = 'failed to delete'
    end
    redirect_to articles_path
  end

  def favorite
    if current_user.favorite_articles.exists?(article_id: params[:id])
      current_user.favorite_articles.where(article_id: params[:id]).destroy_all
    else
      favorite = FavoriteArticle.new
      favorite.user = current_user
      favorite.article = Article.find(params[:id])
      favorite.save
    end
    redirect_to articles_path
  end

  def favorites
    @articles = current_user.user_favorite_articles
  end

  private
    def article_param
      params.require(:article).permit(:title, :content)
    end
end
