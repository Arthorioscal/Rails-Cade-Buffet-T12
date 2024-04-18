class CreateEventPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :event_prices do |t|
      t.references :event, null: false, foreign_key: true
      t.decimal :wd_price
      t.decimal :wd_add_person_price
      t.decimal :wd_extra_hour_price
      t.decimal :we_price
      t.decimal :we_add_person_price
      t.decimal :we_extra_hour_price

      t.timestamps
    end
  end
end
