class Article < ApplicationRecord

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :favorite_articles, dependent: :destroy
  has_many :favorite_users, through: :favorite_articles, source: :user

  validates :title, presence: true
  validates :content, presence: true

end
