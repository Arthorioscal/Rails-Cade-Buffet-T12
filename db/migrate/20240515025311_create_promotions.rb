class CreatePromotions < ActiveRecord::Migration[7.1]
  def change
    create_table :promotions do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.decimal :weekday_discount
      t.decimal :weekend_discount
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
