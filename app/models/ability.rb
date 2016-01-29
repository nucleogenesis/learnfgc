class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    ##
    # Alias Definitions
    ##
    
    # Can Create, Update, Destroy
    alias_action :create, :update, :destroy, to: :cud

    ##
    # God User (Me... presumably)
    ##
    if user.has_role?(:admin)
      can :manage, :all
    end

    ##
    # Article
    ##

  end
end
