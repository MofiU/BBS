class UsersController < ApplicationController
  layout 'user'

  before_action :set_user

  def index

  end

  def edit

  end

  def show

  end

  def favorites

  end

  def following

  end

  def followers

  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
