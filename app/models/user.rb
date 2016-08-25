class User < ApplicationRecord
  attr_accessor :current_password
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }
  has_many :notes
  has_many :topics
  has_many :replies
  after_create_commit :empower
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    },
    :format => { with: /\A[a-zA-Z]+\z/ },
    :length => { in: 4..20 }
  # Only allow letter, number, underscore and punctuation.
  validate :validate_username
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/, message: "格式不正确"

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    find_by(username: conditions[:email]) || find_by(email: conditions[:email])
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
    array.delete(topic_id)
    self.favorite_topic_ids = array.join(',')
    save
    true
  end

  # 是否收藏过话题
  def favorited_topic?(topic_id)
    favorite_topic_ids_array.include?(topic_id)
  end

  def favorite_topics_count
    favorite_topic_ids.size
  end

  def favorite_topic_ids_array
    favorite_topic_ids.split(',')
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

  private

  def empower
    add_role(:user)
  end

end
