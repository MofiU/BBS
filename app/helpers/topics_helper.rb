module TopicsHelper
  def topic_favorite_tag(topic)
    return '' if current_user.blank?
    bookmark_o_icon = raw(content_tag('i', '', class: 'fa fa-bookmark'))
    bookmark_icon = raw(content_tag('i', '', class: 'fa fa-bookmark active'))
    if current_user && current_user.favorite_topic_ids.include?(topic.id.to_s)
      link_to(raw("#{bookmark_icon} 收藏"), unfavorite_topic_path(topic), class: "favorite", remote: true, method: :delete)
    else
      link_to(raw("#{bookmark_o_icon} 收藏"), favorite_topic_path(topic), class: "favorite", remote: true, method: :post)
    end
  end

  def topic_head(topic)
    "由 #{topic.user.username} 于 #{format_time topic.created_at} 创建"
  end

  def like_topic_tag(topic)
    if topic.liked_user_ids.include? current_user.id
      link_to(raw("<i class='fa fa-heart-o active'></i> <span>#{topic.likes_count} 个赞</span>"), unlike_topic_path(topic), class: "like_topic", remote: true, method: :delete)
    else
      link_to(raw("<i class='fa fa-heart-o'></i> <span>#{topic.likes_count} 个赞</span>"), like_topic_path(topic), class: "like_topic", remote: true, method: :post)
    end
  end

  def follow_topic_tag(topic)
    if topic.follower_ids.include? current_user.id
      link_to(raw("<i class='fa fa-eye active'></i>关注"), unfollow_topic_path(topic), class: "follow_topic", remote: true, method: :delete)
    else
      link_to(raw("<i class='fa fa-eye'></i>关注"), follow_topic_path(topic), class: "follow_topic", remote: true, method: :post)
    end
  end

end
