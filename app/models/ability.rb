class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    ##
    # Alias Definitions
    ##
    
    # Can Create, Update, Destroy
    alias_action :create, :read, :update, :destroy, to: :crud

    ##
    # God User (Me... presumably)
    ##
    if user.has_role?(:admin)
      can :manage, :all
    end

    ##
    # Article
    ##

    can :read, Article
    can :crud, Article, user_id: user.id

    ##
    # Question
    ##
    
    can :read, Question
    can :crud, Question, user_id: user.id

    ##
    # Question Comment
    ##
  end
end
