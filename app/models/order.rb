class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  validates :quantity, presence: true, allow_blank: true
  enum status: {pending: 0, confirm: 1, cancled: 2}
  enum is_payment: {approve: 0, cancled: 1}
end
