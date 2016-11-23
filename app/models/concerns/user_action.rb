module UserAction

  def favorited_topics
    Topic.where(id: favorite_topic_ids)
  end

  # 收藏话题
  def favorite_topic(topic_id)
    return false if topic_id.blank?
    return false if favorited_topic?(topic_id)
    self.favorite_topic_ids << topic_id
    self.save!
    true
  end

  # 取消对话题的收藏
  def unfavorite_topic(topic_id)
    return false if topic_id.blank?
    self.favorite_topic_ids.delete(topic_id.to_s)
    save
    true
  end

  # 是否收藏过话题
  def favorited_topic?(topic_id)
    favorite_topic_ids.include?(topic_id.to_s)
  end

  def favorite_topics_count
    favorite_topic_ids.count
  end

  def follow(user_id)
    return false if user_id.blank?
    return false if follow_user?(user_id)
    ActiveRecord::Base.transaction do
      self.following_ids << user_id.to_i
      save!
      user = User.find user_id
      user.follower_ids << id
      user.save!
      true
    end
  end

  def unfollow(user_id)
    return false if user_id.blank?
    ActiveRecord::Base.transaction do
      self.following_ids.delete(user_id.to_i)
      save!
      user = User.find user_id
      user.follower_ids.delete(id)
      user.save!
      true
    end
  end

  def like_topic(topic_id)
    return false if topic_id.blank?
    return false if like_topic?(topic_id)
    topic = Topic.find(topic_id)
    topic.liked_user_ids << id
    topic.likes_count += 1
    topic.save!
    true
  end

  def unlike_topic(topic_id)
    return false if topic_id.blank?
    topic = Topic.find(topic_id)
    topic.liked_user_ids.delete(id)
    topic.likes_count -= 1
    topic.save!
    true
  end

  def follow_topic(topic_id)
    return false if topic_id.blank?
    return false if follow_topic?(topic_id)
    topic = Topic.find(topic_id)
    topic.follower_ids << id
    topic.save!
    true
  end

  def unfollow_topic(topic_id)
    return false if topic_id.blank?
    topic = Topic.find(topic_id)
    topic.follower_ids.delete(id)
    topic.save!
    true
  end

  def block(user_id)
    return false if user_id.blank?
    return false if has_block?(user_id)
    self.blocked_user_ids << user_id
    save!
    true
  end

  def unblock(user_id)
    return false if user_id.blank?
    self.blocked_user_ids.delete(user_id)
    save!
  end


  def calendar_data
    user = self
    date_from = 12.months.ago.beginning_of_month.to_date
    replies = user.replies.where('created_at > ?', date_from)
                  .group("date(created_at)")
                  .select("date(created_at) AS date, count(id) AS total_amount").all

    timestamps = {}
    replies.each do |reply|
      timestamps[reply['date'].to_time.to_i.to_s] = reply['total_amount']
    end
    timestamps
  end

  def follow_user?(user_id)
    following_ids.include? user_id
  end

  def has_block?(user_id)
    blocked_user_ids.include? user_id.to_s
  end

  def has_follow?(user)
    following_ids.include? user.id
  end

  def like_topic?(topic_id)
    Topic.find(topic_id).liked_user_ids.include? id
  end

  def follow_topic?(topic_id)
    Topic.find(topic_id).follower_ids.include? id
  end

  def unread_notifications
    Notification.unreads(self)
  end

  def unread_count
    unread_notifications.count
  end


end