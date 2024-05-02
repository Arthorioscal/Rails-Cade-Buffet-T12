module ApplicationHelper
  def weekday?(date)
    !(date.wday == 0 || date.wday == 6)
  end

  def calculate_final_price(order, price, extra_person_price, extra_hour_price)
    if order.estimated_guests > order.event.min_people && order.estimated_guests < order.event.max_people
      extra_people = order.estimated_guests - order.event.min_people
      extra_people_price = extra_people * extra_person_price
      final_price = extra_people_price + price
    elsif order.estimated_guests <= order.event.min_people
      final_price = price
    else
      final_price = price + extra_person_price + extra_hour_price
    end
    final_price
  end
end
