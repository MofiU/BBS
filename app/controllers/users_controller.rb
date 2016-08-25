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
  ##可以放到module里面去，通过include变为实例方法
  def calendar
    timestamps = @user.calendar_data
    render json: timestamps
    # render json: {Time.now.to_i => 10, 10.months.ago.to_i => 20}
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
