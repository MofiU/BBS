module TopicsHelper
  def topic_favorite_tag(topic)
    return '' if current_user.blank?
    bookmark_o_icon = raw(content_tag('i', '', class: 'fa fa-bookmark'))
    bookmark_icon = raw(content_tag('i', '', class: 'fa fa-bookmark active'))
    if current_user && current_user.favorite_topic_ids_array.include?(topic.id.to_s)
      link_to(raw("#{bookmark_icon} 取消收藏"), unfavorite_topic_path(topic), class: "favorite", remote: true, method: :delete)
    else
      link_to(raw("#{bookmark_o_icon} 收藏"), favorite_topic_path(topic), class: "favorite", remote: true, method: :post)
    end

  end
end
