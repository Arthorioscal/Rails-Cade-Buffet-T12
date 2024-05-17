class Promotion < ApplicationRecord
  belongs_to :event
  has_one :event_price, through: :event

  validates :name, :start_date, :end_date, :weekday_discount, :weekend_discount, presence: true
  validates :weekday_discount, :weekend_discount, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1}
  validate :end_date_after_start_date
  validate :start_date_and_end_date_not_in_past

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, 'deve ser maior que a data de início')
    end
  end

  def start_date_and_end_date_not_in_past
    return if end_date.blank? || start_date.blank?

    if start_date < Date.today || end_date < Date.today
      errors.add(:start_date, 'não pode ser no passado')
      errors.add(:end_date, 'não pode ser no passado')
    end
  end
end
