module RepliesHelper

  def like_reply_tag(reply)
    if reply.liked_user_ids.include? current_user.id
      link_to(raw("<i class='fa fa-heart-o active'></i> <span>#{reply.liked_user_ids.count} 个赞</span>"), unlike_reply_path(reply), class: "like_reply", remote: true, method: :delete)
    else
      link_to(raw("<i class='fa fa-heart-o'></i> <span>#{reply.liked_user_ids.count} 个赞</span>"), like_reply_path(reply), class: "like_reply", remote: true, method: :post)
    end
  end
end
