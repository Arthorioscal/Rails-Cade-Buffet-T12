class Event < ApplicationRecord
  include ApplicationHelper

  belongs_to :buffet
  has_one :event_price
  has_one :promotion
  has_many :orders
  has_many_attached :photos

  validates :name, :description, :min_people, :max_people, :duration, :menu, :buffet_id, presence: true
  validates :alcohol, :decoration, :parking_service, :at_buffet_location, inclusion: { in: [true, false] }
  validates :min_people, :max_people, :duration, numericality: { only_integer: true, greater_than: 0 }
  
  validates :partial_cancellation_days, :total_cancellation_days, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
  validates :partial_cancellation_fine, :total_cancellation_fine, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }, allow_blank: true

  def cancellation_details_present?
    partial_cancellation_fine.present? && total_cancellation_fine.present? && partial_cancellation_days.present? && total_cancellation_days.present?
  end

  def available_on?(date, guests)
    if orders.where(event_date: date).exists? || guests > max_people || date < Date.today || orders.pluck(:status).any? { |status| [1, 2].include?(status) }
      { available: false }
    else
      price = calculate_price(date, guests)
      { available: true, final_price: price }
    end
  end
  
  def calculate_price(date, guests)
    min_guests = self.min_people
    wd_price = self.event_price.wd_price 
    wd_extra_person = self.event_price.wd_add_person_price 
    wd_extra_hour = self.event_price.wd_extra_hour_price 
    we_price = self.event_price.we_price 
    we_extra_person = self.event_price.we_add_person_price 
    we_extra_hour = self.event_price.we_extra_hour_price 
  
    if weekday?(date)
      if guests > min_guests
        extra_people = guests - min_guests
        extra_people_price = extra_people * wd_extra_person
        fina_price = wd_price + extra_people_price
      else
        final_price = wd_price
      end
    else
      if guests > min_guests
        extra_people = guests - min_guests
        extra_people_price = extra_people * we_extra_person
        final_price = we_price + extra_people_price
      else
        final_price = we_price
      end
    end
  end
end