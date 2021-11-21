class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :soccer_field
  after_create :set_order_total_cost
  before_save :set_current_price
  validates_datetime :time_started
  validates_datetime :time_finished
  validates :booking_used, numericality: {only_integer: true,
                                          greater_than_or_equal_to: 0},
                           allow_blank: true
  private
  def set_order_total_cost
    order.total_cost += current_price * booking_used
    order.save
  end

  def set_current_price
    self.current_price = soccer_field.price
  end
end
