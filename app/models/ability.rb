class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    ##
    # Alias Definitions
    ##
    
    # Can Create, Update, Destroy
    alias_action :create, :edit, :update, :destroy, to: :manage_owned_objects

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
    can :manage_owned_objects, Article, user_id: user.id

    ##
    # Question
    ##
    
    can :read, Question
    can :manage_owned_objects, Question, user_id: user.id

    ##
    # Question Comment
    ##
  end
end
