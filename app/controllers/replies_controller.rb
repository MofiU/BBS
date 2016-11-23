class RepliesController < ApplicationController
  before_action :set_reply, only: [:like, :unlike]
  before_action :set_topic, only: :create
  def create
    @reply = Reply.new(body: reply_params[:body], topic_id: @topic.id, user_id: current_user.id)
    if @reply.save
      @topic.replies_count += 1
      @topic.save!
      current_user.replies_count += 1
      current_user.save!
      redirect_to topic_path(@topic), notice: '回复成功'
    else
      redirect_to topic_path(@topic), alert: '回复失败'
    end
  end

  def like

  end

  def unlike

  end

  private

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def set_topic
    @topic = Topic.find(reply_params[:topic_id])
  end

  def reply_params
    params.require(:reply).permit(:body, :topic_id)
  end

end
