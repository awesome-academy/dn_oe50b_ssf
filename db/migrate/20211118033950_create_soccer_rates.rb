class CreateSoccerRates < ActiveRecord::Migration[6.1]
  def change
    create_table :soccer_rates do |t|
      t.references :user, null: false, foreign_key: true
      t.references :soccer_field, null: false, foreign_key: true
      t.text :comment
      t.integer :rate

      t.timestamps
    end
  end
end
