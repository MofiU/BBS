class HomeController < ApplicationController
  # before_action :authenticate_user!
  def index
    @cream_topics = Topic.all.limit(5)
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
