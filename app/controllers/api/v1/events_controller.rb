class Api::V1::EventsController < Api::V1::ApiController
    def index
        @buffet = Buffet.find_by(id: params[:buffet_id], active: true)
        if @buffet
            @events = @buffet.events.select(&:active).map do |event|
                event.attributes.transform_values { |value| value.is_a?(TrueClass) || value.is_a?(FalseClass) ? I18n.t(value.to_s) : value }
            end
            render status: 200, json: @events
        else
            render status: 404, json: { message: "Buffet not found" }
        end
    end

    def availability
        @buffet = Buffet.find(params[:buffet_id])
        @event = @buffet.events.find_by(id: params[:id], active: true)
        
        if @event.nil?
            render status: 404, json: { message: "Event not found or not active" } and return
        end
        
        date = Date.parse(params[:date])
        guests = params[:guests].to_i
        
        availability = @event.available_on?(date, guests)
    
        if availability[:available] && @event.active && @event.buffet.active
            render status: 200, json: { available: true, final_price: availability[:final_price] }
        else
            render status: 200, json: { available: false }
        end
    end
    
end
