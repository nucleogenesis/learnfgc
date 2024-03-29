class User < ActiveRecord::Base
  include Clearance::User

  has_many :articles

  before_save :verify_role_format

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false }, 
    length: { minimum: 4 }

  def has_role? role
    return false if self.roles.nil?
    self.roles.split(',').include? role
  end

  private
  def verify_role_format
    return if self.roles.nil?
    self.roles = self.roles.gsub(/\s*,\s*/, ',')
  end
end
