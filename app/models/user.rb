class User < ApplicationRecord
  include UserAction
  attr_accessor :current_password
  serialize :favorite_topic_ids , Array
  serialize :blocked_user_ids , Array
  serialize :follower_ids , Array
  serialize :following_ids , Array
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }
  has_many :notes
  has_many :topics
  has_many :replies
  has_many :notifications
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

  private

  def empower
    add_role(:user)
  end

end
