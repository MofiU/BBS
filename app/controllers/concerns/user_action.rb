module UserAction
  def favorited_topics
    Topic.where(id: favorite_topic_ids_array)
  end

  # 收藏话题
  def favorite_topic(topic_id)
    return false if topic_id.blank?
    return false if favorited_topic?(topic_id)
    self.favorite_topic_ids = "#{favorite_topic_ids},#{topic_id}"
    self.save!
    true
  end

  # 取消对话题的收藏
  def unfavorite_topic(topic_id)
    return false if topic_id.blank?
    array = favorite_topic_ids_array
    array.delete(topic_id.to_s)
    self.favorite_topic_ids = array.join(',')
    save
    true
  end

  # 是否收藏过话题
  def favorited_topic?(topic_id)
    favorite_topic_ids_array.include?(topic_id)
  end

  def favorite_topics_count
    favorite_topic_ids_array.size
  end

  def favorite_topic_ids_array
    favorite_topic_ids.split(',').reject { |f| f.empty? }
  end


  def follow(user_id)
    return false if user_id.blank?
    return false if follow_user?(user_id)
    ActiveRecord::Base.transaction do
      self.following_ids = "#{following_ids},#{user_id}"
      save!
      user = User.find user_id
      user.follower_ids = "#{user.follower_ids},#{self.id}"
      user.save!
      true
    end
  end

  def unfollow(user_id)
    return false if user_id.blank?
    ActiveRecord::Base.transaction do
      array = following_ids_array
      array.delete(user_id.to_s)
      self.following_ids = array.join(',')
      save!
      user = User.find user_id
      array = user.follow_ids_array
      array.delete(self.id.to_s)
      user.follower_ids = array.join(',')
      user.save!
      true
    end
  end

  def follow_ids_array
    follower_ids.split(',').reject { |f| f.empty? }
  end

  def follow_count
    follow_ids_array.count
  end

  def following_ids_array
    following_ids.split(',').reject { |f| f.empty? }
  end

  def following_count
    following_ids_array.count
  end

  def block(user_id)
    return false if user_id.blank?
    return false if block_user?(user_id.to_s)
    self.blocked_user_ids = "#{blocked_user_ids},#{user_id}"
    save
    true
  end

  def unblock(user_id)
    return false if user_id.blank?
    array = block_user_ids_array
    array.delete(user_id.to_s)
    self.blocked_user_ids = array.join(',')
    save
  end

  def block_user_ids_array
    blocked_user_ids.split(',').reject { |f| f.empty? }
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
    p '=================='
    p following_ids_array
    p user_id.to_s
    following_ids_array.include? user_id.to_s
  end

  def block_user?
    block_user_ids_array.include? user_id.to_s
  end

  def has_follow?(user)
    following_ids_array.include? user.id.to_s
  end

end