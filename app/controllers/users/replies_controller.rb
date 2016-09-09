class Users::RepliesController < Users::ApplicationController
  before_action :set_user
  def index
    @replies = @user.replies.includes(:topic).order(created_at: :desc).page params[:page]
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
