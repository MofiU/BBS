class UsersController < ApplicationController
  layout 'user', except: :edit

  before_action :set_user

  def index

  end

  def edit
  end

  def show

  end

  def favorites
    @topics = @user.favorited_topics.includes(:node)
  end

  def following
    @users = User.where(id: @user.following_ids_array)
  end

  def followers
    @users = User.where(id: @user.follow_ids_array)
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
  end

  def unblock
    current_user.unblock(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
