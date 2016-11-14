class Users::TopicsController < Users::ApplicationController

  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @topics = @user.topics.page params[:page]
  end

  def show
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def set_user
    @user = User.includes(:topics).find(params[:id])
  end

end
