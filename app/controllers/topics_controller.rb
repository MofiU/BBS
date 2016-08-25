class TopicsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy,
                                            :favorite, :unfavorite, :follow, :unfollow]

  load_and_authorize_resource

  def index
    @topics = Topic.all
  end

  def show
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(title: topic_params[:title], body: topic_params[:body], user_id: current_user.id)
    if @topic.save
      redirect_to topic_path(@topic)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to topic_url(@topic)
    else
      render 'edit'
    end
  end

  def close
    @topic.update!(closed: true)
    redirect_to topics_path
  end

  def destroy
    @topic.destroy
    redirect_to topics_path
  end

  def favorite
    current_user.favorite_topic(params[:id])
  end

  def unfavorite
    current_user.unfavorite_topic(params[:id])
    render 'favorite'
  end

  def follow

  end

  def unfollow

  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body)
  end

end
