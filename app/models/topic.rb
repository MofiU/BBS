class Topic < ApplicationRecord
  validates :title, :presence => true
  validates :body, :presence => true
  belongs_to :user
  belongs_to :node
  has_many :replies
  serialize :liked_user_ids, Array
  serialize :follower_ids, Array
  scope :recently, ->{order(created_at: :desc).limit(10)}
  scope :creams, ->{where(cream: true, deleted: nil)}
  scope :active, ->{where(deleted_at: nil)}
end
