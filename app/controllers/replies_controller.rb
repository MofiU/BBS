class RepliesController < ApplicationController
  before_action :set_reply, except: [:index, :show, :create]
  before_action :set_topic
  def create
    @reply = Reply.new(body: reply_params[:body], topic_id: @topic.id, user_id: current_user.id)
    if @reply.save
      @topic.replies_count += 1
      @topic.save!
      flash[:notice] = "回复成功"
    else
      flash[:alert] = "回复失败"
    end
    redirect_to topic_path(@topic)
  end

  private

  def set_reply
    @reply = Reply.find(reply_params[:id])
  end

  def set_topic
    @topic = Topic.find(reply_params[:topic_id])

  end

  def reply_params
    params.require(:reply).permit(:body, :topic_id)
  end

end
