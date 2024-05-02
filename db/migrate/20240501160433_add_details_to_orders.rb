class AddDetailsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :final_price, :decimal
    add_column :orders, :valid_until, :date
    add_column :orders, :extra_fee, :decimal
    add_column :orders, :discount, :decimal
    add_column :orders, :description, :text
    add_column :orders, :order_payment_method, :string
  end
end
