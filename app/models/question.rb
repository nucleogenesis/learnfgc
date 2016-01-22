class Question < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  has_many :question_comments

  validates :content, presence: true
end
