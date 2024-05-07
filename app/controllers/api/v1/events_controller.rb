class Api::V1::EventsController < Api::V1::ApiController
    def index
        @events = Event.all
        render status: 200, json: @events
    end
end