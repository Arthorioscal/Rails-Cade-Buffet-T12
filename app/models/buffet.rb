class Buffet < ApplicationRecord
  belongs_to :user

  has_one_attached :cover_photo
  
  has_many :events
  has_many :event_prices, through: :events
  has_many :orders
  has_many :reviews

  validates :brand_name, :corporate_name, :cnpj, :phone, :email, :address, :neighborhood, :state, :city, :zip_code, :description, :payment_methods, presence: true
  validates :cnpj, :email, uniqueness: true
  validates :cnpj, cnpj: { message: 'Inválido, tente novamente.' }

  def self.search(search, active: true)
    if search
      where("brand_name LIKE ? AND active = ?", "%#{search}%", active)
    else
      where(active: active)
    end
  end
  
  def average_rating
    reviews.average(:rating)
  end
end
