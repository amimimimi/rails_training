class AddKeyToFavoriteArticles < ActiveRecord::Migration[5.2]
  def change
    add_index :favorite_articles, [:user_id, :article_id], unique: true
  end
end
