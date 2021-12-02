class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :soccer_field
  scope :newest, ->{order created_at: :desc}

  delegate :name, to: :user
end
