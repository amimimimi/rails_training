class Article < ApplicationRecord
  belongs_to :user
  has_many :favorite_articles
  has_many :favorite_users, through: :favorite_articles, source: :user

  validates :title, presence: true
  validates :content, presence: true

  before_destroy :allow_destroy

  private
    def allow_destroy
      # todo
    end
end
