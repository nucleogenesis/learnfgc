class Character < ActiveRecord::Base
  belongs_to :game

  SLUG_REGEX = /\A[a-z0-9]+(?:(\-)+[a-z0-9]+)*\z/

  validates :name, presence: true
  validates :history, presence: true
  validates :game_id, presence: true
  validate  :slug_has_been_created
  validates :slug, presence: true, uniqueness: true, 
    format: { with: SLUG_REGEX },
    on: :create

  def to_param
    slug
  end

  private
  def slug_has_been_created
    return unless self.name
    if self.slug.nil?
      slugify
    end
  end

  def slugify
    self.slug = self.name.gsub(/(?:( |\W)+)+/, "-").downcase
    self.slug = self.slug.gsub(/( |\W)\z/, "")
  end
end
