class Game < ActiveRecord::Base
  has_many :characters

  SLUG_REGEX = /\A[a-z0-9]+(?:(\-)+[a-z0-9]+)*\z/

  validates :abbr, presence: true
  validates :title, presence: true
  validate  :slug_has_been_created
  validates :slug, presence: true, uniqueness: true, 
    format: { with: SLUG_REGEX },
    on: :create

  def to_param
    slug
  end

  private
  def slug_has_been_created
    return unless self.title
    if self.slug.nil?
      slugify
    end
  end

  def slugify
    self.slug = self.title.gsub(/(?:( |\W)+)+/, "-").downcase
    self.slug = self.slug.gsub(/( |\W)\z/, "")
  end
end
