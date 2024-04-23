class Buffet < ApplicationRecord
  belongs_to :user
  
  has_many :events
  has_many :event_prices, through: :events

  validates :brand_name, :corporate_name, :cnpj, :phone, :email, :address, :neighborhood, :state, :city, :zip_code, :description, :payment_methods, presence: true
end
