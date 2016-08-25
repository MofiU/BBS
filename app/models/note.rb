class Note < ApplicationRecord
  validates :title, :presence => true
  validates :body, :presence => true
  belongs_to :user
  scope :recently, ->{order(created_at: :desc).limit(10)}
  scope :publish, -> {where(public: true)}
end
