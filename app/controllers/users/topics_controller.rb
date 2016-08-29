class Users::TopicsController < Users::ApplicationController

  before_action :get_recent_topics, except: [:create, :destroy]
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @topics = @user.topics
  end

  def show
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body)
  end

  def get_recent_topics
    @recent_topics = current_user.topics.recently
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def set_user
    @user = User.includes(:topics).find(params[:id])
  end

end
