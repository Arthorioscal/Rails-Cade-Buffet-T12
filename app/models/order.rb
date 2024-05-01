class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :event
  belongs_to :user

  enum status: { awaiting_evaluation: 0, confirmed: 1}

  validates :event_date, :estimated_guests, :details, :order_code, :status, presence: true
  validates :estimated_guests, numericality: { only_integer: true, greater_than: 0 }
  validates :order_code, length: { is: 8 }
  validates :status, inclusion: { in: %w[awaiting_evaluation confirmed cancelled] }
  validate :event_address_required_if_at_buffet_location
  #validates :event_date_cannot_be_in_the_past

  before_validation :generate_order_code, on: :create


  private

  def generate_order_code
    self.order_code ||= SecureRandom.alphanumeric(8)
  end

  #def event_date_cannot_be_in_the_past
  #  errors.add(:event_date, 'não pode ser no passado') if event_date.present? && event_date < Date.today
  #end

  def event_address_required_if_at_buffet_location
    if event.at_buffet_location? && event_address.blank?
      errors.add(:event_address, "deve ser preenchido se o evento for fora do buffet")
    end
  end
end