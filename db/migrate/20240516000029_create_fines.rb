class CreateFines < ActiveRecord::Migration[7.1]
  def change
    create_table :fines do |t|
      t.references :order, null: false, foreign_key: true
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
