class HomeController < ApplicationController
  # before_action :authenticate_user!
  def index
    if user_signed_in?
      @cream_topics = Topic.order(created_at: :desc).where.not(user_id: current_user.blocked_user_ids).limit(5)
    else
      @cream_topics = Topic.order(created_at: :desc).limit(5)
    end
    @nodes = Node.all
    @users = User.all

  end

  def error_404
    render 'errors/404'
  end

  def error_500
    render 'errors/500'
  end

end
