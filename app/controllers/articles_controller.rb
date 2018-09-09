class ArticlesController < ApplicationController

  # get /articles(.:format)
  def index
    @articles = Article.all.order(created_at: 'desc').includes(:user)
  end

  # get /articles/new(.:format)
  def new
    @article = Article.new
  end

  # post /articles(.:format)
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

  # get /articles/:id(.:format)
  def show
    @article = Article.find(params[:id])
  end

  # get /articles/:id/edit(.:format)
  def edit
    @article = Article.find(params[:id])
  end

  # put /articles/:id(.:format)
  def update
    @article = Article.find(params[:id])
    if @article.update(article_param)
      flash[:notice] = 'saved successfully'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  # delete /articles/:id(.:format)
  def destroy
    @article = current_user.articles.find_by(article_id: params[:id])
    if @article.destroy
      flash[:notice] = 'deleted successfully'
    else
      flash[:alert] = 'failed to delete'
    end
    redirect_to articles_path
  end

  # post /articles/:id/favorite(.:format)
  def favorite
    article = Article.find(params[:id])
    if current_user.is_favorite?(article)
      current_user.not_favorites(article)
    else
      current_user.add_favorites(article)
    end
    redirect_to request.referrer
  end

  # get /articles/favorites(.:format)
  def favorites
    @articles = current_user.user_favorite_articles
  end

  private
    def article_param
      params.require(:article).permit(:title, :content, :image)
    end
end
