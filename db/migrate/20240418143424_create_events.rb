class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.integer :min_people
      t.integer :max_people
      t.integer :duration
      t.text :menu
      t.boolean :alcohol
      t.boolean :decoration
      t.boolean :parking_service
      t.boolean :at_buffet_location
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
