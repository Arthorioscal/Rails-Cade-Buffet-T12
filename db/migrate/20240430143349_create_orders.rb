class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :buffet, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.date :event_date
      t.integer :estimated_guests
      t.text :details
      t.string :order_code
      t.integer :status
      t.string :event_address

      t.timestamps
    end
  end
end
