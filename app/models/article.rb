class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  belongs_to :character
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :questions

  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true
  validates :user_id, presence: true
  validate  :ensure_slug_has_been_created, on: :create
  validate  :ensure_slug_is_unique, on: :create
  validates :slug, presence: true, uniqueness: true, 
    format: { with: Slug.slug_regex }

  def to_param
    slug
  end

  def author
    self.user.username
  end

  private
  def ensure_slug_is_unique
    return if Article.find_by_slug(self.slug).nil?
    self.slug += "-#{Time.now.to_formatted_s(:number)}"
  end

  def ensure_slug_has_been_created
    return unless self.title && self.slug.nil?
    self.slug = Slug.slugify(self.title)
  end
end
