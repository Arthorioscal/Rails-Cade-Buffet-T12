class EventsController < ApplicationController
    before_action :authenticate_user!

    def index
        @events = Event.all
    end

    def new
        @buffet = current_user.buffet
        @event = Event.new
    end

    def create
        @buffet = current_user.buffet
        @event = Event.new(event_params)
        if @event.save
            redirect_to events_path(@event), notice: 'Tipo de evento cadastrado com sucesso.'
        else
            flash.now[:notice] = 'Não foi possível cadastrar o tipo de evento, tente novamente'
            render :new
        end
    end

    def edit
        @buffet = current_user.buffet
        @event = Event.find(params[:id])
    end

    def update
        @buffet = current_user.buffet
        @event = Event.find(params[:id])
        if @event.update(event_params)
            redirect_to events_path(@event), notice: 'Tipo de evento atualizado com sucesso.'
        else
            flash.now[:notice] = 'Não foi possível atualizar o tipo de evento, tente novamente'
            render :edit
        end
    end

    private

    def event_params
        params.require(:event).permit(:name, :description, :min_people, :max_people, :duration, :menu, :alcohol, :decoration, :parking_service, :at_buffet_location, :buffet_id)    end
end