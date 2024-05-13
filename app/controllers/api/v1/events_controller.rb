class Api::V1::EventsController < Api::V1::ApiController
    def index
        @buffet = Buffet.find_by_id(params[:buffet_id])
        if @buffet
            @events = @buffet.events.map do |event|
                event.attributes.transform_values { |value| value.is_a?(TrueClass) || value.is_a?(FalseClass) ? I18n.t(value.to_s) : value }
            end
            render status: 200, json: @events
        else
            render status: 404, json: { message: "Buffet not found" }
        end
    end

    def availability
        @event = Event.find(params[:id])
        date = Date.parse(params[:date])
        guests = params[:guests].to_i
    
        availability = @event.available_on?(date, guests)
    
        if availability[:available]
            render status: 200, json: { available: true, final_price: availability[:final_price] }
        else
            render status: 200, json: { available: false }
        end
    end
end
