class Node < ApplicationRecord
  has_many :topics, ->{where(deleted_at: nil)}
end
