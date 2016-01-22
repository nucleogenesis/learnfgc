class Slug
  SLUG_REGEX = /\A[a-z0-9]+(?:(\-)+[a-z0-9]+)*\z/

  def self.slugify text
    slug = text.gsub(/(?:( |\W))+/, "-")
    slug = slug.gsub(/( |\W)\z/, "")
    return slug.downcase
  end

  def self.slug_regex
    SLUG_REGEX
  end

  def self.is_valid? slug
    !(slug =~ SLUG_REGEX).nil?
  end
end
