class Question < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  has_many :question_comments

  validates :content, presence: true
  validates :user_id, presence: true
  validates :article_id, presence: true
end
