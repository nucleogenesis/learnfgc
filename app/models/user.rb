class User < ActiveRecord::Base
  include Clearance::User

  has_many :articles

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false }, 
    length: { minimum: 4 }

end
