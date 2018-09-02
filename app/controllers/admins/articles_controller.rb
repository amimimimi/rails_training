class Admins::ArticlesController < Admins::Base
  def index
    @articles = Article.all.order(created_at: 'desc')
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = 'deleted successfully'
    else
      flash[:alert] = 'failed to delete'
    end
    redirect_to admins_articles_path
  end

end
