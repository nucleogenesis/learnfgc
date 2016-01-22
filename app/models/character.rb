class Character < ActiveRecord::Base
  belongs_to :game

  validates :name, presence: true
  validates :history, presence: true
  validates :game_id, presence: true
  validate  :ensure_slug_has_been_created, on: :create
  validates :slug, presence: true,
    format: { with: Slug.slug_regex },
    on: :create

  def to_param
    slug
  end

  private
  def ensure_slug_has_been_created
    return unless self.name && self.slug.nil?
    self.slug = Slug.slugify(self.name)
  end
end
