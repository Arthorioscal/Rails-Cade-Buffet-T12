class Api::V1::EventsController < Api::V1::ApiController
    def index
        @events = Event.all
        render status: 200, json: @events
    end

    def buffet_events
        @buffets = Buffet.find(params[:id])
        @events = @buffets.events
        render status: 200, json: @events
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
