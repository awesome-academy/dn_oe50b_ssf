class SoccerField < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :soccer_rates, dependent: :destroy

  validates :field_name, length:
                         {maximum: Settings.model.profile.length_digit_50},
                         allow_blank: true
  validates :type, numericality: {only_integer: true}
  validates :address, length:
                      {maximum: Settings.model.profile.length_digit_255},
                      allow_blank: true
  enum status: {left: 0, over: 1}
  validates :price, numericality: {only_integer: true,
                                   greater_than_or_equal_to: 0},
                    allow_blank: true
end
