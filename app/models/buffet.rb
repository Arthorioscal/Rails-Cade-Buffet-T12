class Buffet < ApplicationRecord
  belongs_to :user
  validates :brand_name, :corporate_name, :cnpj, :phone, :email, :address, :neighborhood, :state, :city, :zip_code, :description, :payment_methods, presence: true
end
