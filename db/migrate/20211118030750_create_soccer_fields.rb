class CreateSoccerFields < ActiveRecord::Migration[6.1]
  def change
    create_table :soccer_fields do |t|
      t.string :field_name
      t.integer :type
      t.bigint :price
      t.integer :status
      t.string :address

      t.timestamps
    end
  end
end
