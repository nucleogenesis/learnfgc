class Revision < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  has_many :revision_comments
  
  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
  validates :article_id, presence: true
end
