class Article < ActiveRecord::Base
  # ALL CODE IS STRICTLY TO ALLOW USE OF FORM HELPERS
  # IN DESIGN OF FRONT END STATIC MOCKUPS
  attr_accessor :title, :tags, :content, :author
end
