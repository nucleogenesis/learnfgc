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
    # GDLK User (Me... presumably)
    ##
    if user.has_role?(:admin)
      can :manage, :all
    end

    ##
    # Scrub Users (Them, naturally)
    ##
    can :read, :all

    ##
    # Article
    ##
    can :manage_owned_objects, Article, user_id: user.id

    ##
    # Question
    ##
    can :manage_owned_objects, Question, user_id: user.id

    ##
    # Question Comment
    ##
    can :manage_owned_objects, QuestionComment, user_id: user.id

    ##
    # Revisions
    ##
    can :manage_owned_objects, Revision, user_id: user.id
  end
end
