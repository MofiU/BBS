class UsersController < ApplicationController
  layout 'user', except: [:edit, :index]

  before_action :set_user, except: [:index]

  def index
    @users = User.all.page params[:page]
  end

  def edit
  end

  def show

  end

  def favorites
    @topics = @user.favorited_topics.includes(:node).order(created_at: :desc).page params[:page]
  end

  def following
    @users = User.where(id: @user.following_ids)
  end

  def followers
    @users = User.where(id: @user.follower_ids)
  end
  ##可以放到module里面去，通过include变为实例方法
  def calendar
    timestamps = @user.calendar_data
    render json: timestamps
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def follow
    current_user.follow(params[:id])
    @user.reload
  end

  def unfollow
    current_user.unfollow(params[:id])
    @user.reload
    render 'follow'
  end

  def block
    current_user.block(params[:id])
    @user.reload
  end

  def unblock
    current_user.unblock(params[:id])
    render 'block'
  end

  def grant_user
    @user.remove_role :admin
    @user.add_role :user
    redirect_back(fallback_location: root_path, notice: '操作成功！')
  end

  def grant_admin
    @user.add_role :admin
    redirect_back(fallback_location: root_path, notice: '操作成功！')
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
