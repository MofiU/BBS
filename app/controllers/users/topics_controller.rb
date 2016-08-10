class Users::TopicsController < ApplicationController

  before_action :get_recent_topics, except: [:create, :destroy]

  def index
    @topics = current_user.topics
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.create(title: topic_params[:title], body: topic_params[:body], user_id: current_user.id)
    if @topic.valid?
      redirect_to users_topic_path(@topic)
    else
      render 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      redirect_to users_topic_url(@topic)
    else
      render 'edit'
    end
  end

  def destroy
    topic = Topic.find(params[:id])
    topic.update!(deleted_at: Time.now)
    redirect_to users_topics_path
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body)
  end

  def get_recent_topics
    @recent_topics = current_user.topics.recently
  end

end
