module ApplicationHelper
  def is_favorite?(article)
    article.exists?(user_id: current_user.id)
  end
end
