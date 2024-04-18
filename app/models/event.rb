class Event < ApplicationRecord
  belongs_to :buffet
  has_one :event_price

  validates :name, :description, :min_people, :max_people, :duration, :menu, :buffet_id, presence: true
  validates :alcohol, :decoration, :parking_service, :at_buffet_location, inclusion: { in: [true, false] }
end