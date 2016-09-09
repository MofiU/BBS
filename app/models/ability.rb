class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    @user = user
    @user ||= User.new # guest user (not logged in)
    if @user.has_role? :admin
      can :manage, :all
    elsif @user.has_role? :user
      roles_for_members
    else
      roles_for_anonymous
    end
  end

  protected

  #普通会员权限

  def roles_for_members
    roles_for_topics
    roles_for_replies
    roles_for_notes
    roles_for_photos
    basic_read_only
  end

  #未登陆权限
  def roles_for_anonymous
    cannot :manage, :all
    basic_read_only
  end

  def roles_for_topics
    can [:favorite, :unfavorite, :follow, :unfollow, :favorites, :like, :unlike], Topic
    can [:update, :create, :close], Topic, user_id: user.id
    can :destroy, Topic do |topic|
        topic.user_id == user.id && topic.replies_count == 0
    end
  end

  def roles_for_replies
    cannot :create, Reply, topic: {closed: true}
    can [:updtaed, :destroy], Reply, user_id: user.id
  end

  def roles_for_notes
    can :create, Note
    can [:update, :destroy, :read], Note, user_id: user.id
    can :read, Note, public: true
  end

  def roles_for_photos
    can :create, Photo
    can :update, Photo, user_id: user.id
    can :destroy, Photo, user_id: user.id
  end

  def basic_read_only
    can :read, Topic
    can :read, Reply
    can :read, Node
  end

end
