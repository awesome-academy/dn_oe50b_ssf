class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: {unique: true}
      t.string :password_digest
      t.string :remember_digest
      t.integer :role, null: false, default: 0
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      
      t.timestamps
    end
  end
end
