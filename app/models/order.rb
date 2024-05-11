class Order < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :buffet
  belongs_to :event
  belongs_to :user

  enum status: { awaiting_evaluation: 0, confirmed_by_owner: 1, confirmed: 2, canceled: 3}

  validates :event_date, :estimated_guests, :details, :order_code, :status, presence: true
  validates :estimated_guests, numericality: { only_integer: true, greater_than: 0 }
  validates :order_code, length: { is: 8 }

  validates :status, inclusion: { in: %w[awaiting_evaluation confirmed_by_owner confirmed canceled] }

  validates :valid_until, :final_price, :discount, :extra_fee, :description, presence: true, if: :status_confirmed?
  
  validate :event_date_cannot_be_in_the_past
  validate :event_address_required_if_at_buffet_location
  #validate :valid_until_cannot_be_in_the_past

  before_validation :generate_order_code, on: :create


  private

  def generate_order_code
    self.order_code ||= SecureRandom.alphanumeric(8).upcase
  end

  def event_date_cannot_be_in_the_past
    if self.event_date.present? && self.event_date < Date.today
      self.errors.add(:event_date, 'não pode ser no passado')
    end
  end

  def event_address_required_if_at_buffet_location
    if event && event.at_buffet_location? && event_address.blank?
      errors.add(:event_address, "deve ser preenchido se o evento for fora do buffet")
    end
  end

  def status_confirmed?
    status == 'confirmed_by_owner' || status == 'confirmed'
  end

  #def valid_until_cannot_be_in_the_past
  #  if self.valid_until.present? && self.valid_until < Date.today
  #    self.errors.add(:valid_until, 'O pedido expirou')
  # end
  #end

  #def cancel_if_not_confirmed_and_event_date_passed
  #  if !status_confirmed? || status == 'awaiting_evaluation' && event_date < Date.current
  #    self.status = 'canceled'
  #    self.save
  #  end
  #end
end