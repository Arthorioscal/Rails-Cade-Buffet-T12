class Buffet < ApplicationRecord
  belongs_to :user
  
  has_many :events
  has_many :event_prices, through: :events
  has_many :orders

  validates :brand_name, :corporate_name, :cnpj, :phone, :email, :address, :neighborhood, :state, :city, :zip_code, :description, :payment_methods, presence: true
  validates :cnpj, :email, uniqueness: true
  validates :cnpj, cnpj: { message: 'Inválido, tente novamente.' }

  def self.search(search)
    search ? where("brand_name LIKE ?", "%#{search}%") : all
  end
end
