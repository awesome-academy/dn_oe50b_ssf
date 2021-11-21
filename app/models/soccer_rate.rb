class SoccerRate < ApplicationRecord
  belongs_to :user
  belongs_to :soccer_field
  validates :rate, numericality: {only_integer: true}
  validates :comment, length: {maximum: Settings.model.profile.length_digit_255}
end
