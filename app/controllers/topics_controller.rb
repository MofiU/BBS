class TopicsController < ApplicationController
  layout 'topic', only: [:favorites, :index, :creams]

  before_action :authenticate_user!, except: [:index, :show]

  # before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy,
  #                                           :favorite, :unfavorite, :follow, :unfollow]

  load_and_authorize_resource

  def index
    if user_signed_in?
      @topics = Topic.order(created_at: :desc).where.not(user_id: current_user.blocked_user_ids).includes(:user).page params[:page]
    else
      @topics = Topic.order(created_at: :desc).includes(:user).page params[:page]
    end
  end

  def show
    @reply = Reply.new
    @replies = @topic.replies.includes(:user)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(title: topic_params[:title], body: topic_params[:body], user_id: current_user.id)
    if @topic.save
      current_user.topics_count += 1
      current_user.save!
      redirect_to topic_path(@topic)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to topic_url(@topic), notice: '帖子更新成功'
    else
      render 'edit'
    end
  end

  def close
    @topic.update!(closed: true)
    redirect_to topics_path
  end

  def destroy
    if @topic.destroy
      current_user.topics_count -= 1
      current_user.save!
      User.all.each do |user|
        if user.favorite_topic_ids.include? params[:id]
          user.favorite_topic_ids.delete(params[:id])
          user.save!
        end
      end
      redirect_to topics_path, notice: '删帖成功'
    else
      redirect_to topics_path, alert: '程序异常，删帖失败'
    end
  end

  def favorite
    current_user.favorite_topic(params[:id])
  end

  def unfavorite
    current_user.unfavorite_topic(params[:id])
    render 'favorite'
  end

  def follow
    current_user.follow_topic(params[:id])
    @topic.reload
  end

  def unfollow
    current_user.unfollow_topic(params[:id])
    @topic.reload
    render 'follow'
  end

  def favorites
    @topics = current_user.favorited_topics.includes(:user).order(created_at: :desc).page params[:page]
  end

  def like
    current_user.like_topic(params[:id])
    @topic.reload
  end

  def unlike
    current_user.unlike_topic(params[:id])
    @topic.reload
    render 'like'
  end

  def creams
    if user_signed_in?
      @topics = Topic.order(created_at: :desc).where.not(user_id: current_user.blocked_user_ids).includes(:user).page params[:page]
    else
      @topics = Topic.order(created_at: :desc).includes(:user).page params[:page]
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body)
  end

end
