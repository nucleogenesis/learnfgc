class Question < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  has_many :question_comments

  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
  validates :article_id, presence: true

  def author
    self.user.username
  end
end
