class Game < ActiveRecord::Base
  has_many :characters

  attr_accessor :tags ##### FIX THIS #@#####

  validates :title, presence: true, length: { minimum: 5 }
  validate  :ensure_slug_has_been_created, on: :create
  validates :slug, presence: true, uniqueness: true, 
    format: { with: Slug.slug_regex },
    on: :create

  def to_param
    slug
  end

  private
  def ensure_slug_has_been_created
    return unless self.title && self.slug.nil?
    self.slug = Slug.slugify(self.title)
  end
end
