class EventPrice < ApplicationRecord
  belongs_to :event

  validates :wd_price, :wd_add_person_price, :wd_extra_hour_price, :we_price, :we_add_person_price, :we_extra_hour_price, presence: true
end
