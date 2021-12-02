class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.references :soccer_field, null: false, foreign_key: true
      t.bigint :current_price
      t.integer :booking_used, null: false

      t.timestamps
    end
  end
end
