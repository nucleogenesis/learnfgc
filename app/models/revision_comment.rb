class RevisionComment < ActiveRecord::Base
  belongs_to :revision
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true
  validates :revision_id, presence: true
end
