class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :cnpj
      t.string :phone
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :state
      t.string :city
      t.string :zip_code
      t.text :description
      t.string :payment_methods
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
