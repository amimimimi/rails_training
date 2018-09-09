class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  mount_uploader :image, ImageUploader

  has_many :articles, dependent: :destroy

  has_many :favorite_articles, dependent: :destroy
  has_many :user_favorite_articles, through: :favorite_articles, source: :article

  has_many :active_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :passive_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :active_relationships
  has_many :follower, through: :passive_relationships

  # お気に入りかどうか確認する
  def is_favorite?(article)
    user_favorite_articles.include?(article)
  end

  # お気に入りに登録する
  def add_favorites(article)
    favorite_articles.create(article_id: article.id)
  end

  # お気に入りから削除する
  def not_favorites(article)
    favorite_articles.find_by(article_id: article.id).destroy
  end

  # フォローしているか確認する
  def following?(other_user)
    following.include?(other_user)
  end

  # フォローされているか確認する
  def follower?(other_user)
    follower.include?(other_user)
  end

  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(following_id: other_user.id)
  end

  # フォローを外す
  def unfollow(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end

end
