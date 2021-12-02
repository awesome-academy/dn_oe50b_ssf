class SoccerField < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :soccer_rates, dependent: :destroy
  has_many :comments, dependent: :destroy
  scope :order_by_field_name, ->{order :field_name}
  validates :field_name, length:
                         {maximum: Settings.model.profile.name_length_max_50},
                         allow_blank: true
  validates :type_field, numericality: {only_integer: true}
  validates :address, length:
                      {maximum: Settings.model.profile.length_max_255},
                      allow_blank: true
  enum status: {left: 0, over: 1}
  validates :price, numericality: {only_integer: true,
                                   greater_than_or_equal_to: 0},
                    allow_blank: true

  scope :search_name, (lambda do |pr|
    where("lower(field_name) LIKE :search", search: "%#{pr}%") if pr.present?
  end)
end
