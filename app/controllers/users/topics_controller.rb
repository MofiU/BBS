class Users::TopicsController < Users::ApplicationController

  before_action :get_recent_topics, except: [:create, :destroy]
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = current_user.topics
  end

  def show
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(title: topic_params[:title], body: topic_params[:body], user_id: current_user.id)
    if @topic.save
      redirect_to users_topic_path(@topic)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to users_topic_url(@topic)
    else
      render 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to users_topics_path
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

end
