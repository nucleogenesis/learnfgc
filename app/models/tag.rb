class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :articles, through: :taggings

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
end
