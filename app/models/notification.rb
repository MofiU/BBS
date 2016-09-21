class Notification < ApplicationRecord
  belongs_to :user
  scope :unreads, ->(user){where(read: false, user_id: user.id)}

  validates_presence_of :title, :body, :type, :user_id
end
