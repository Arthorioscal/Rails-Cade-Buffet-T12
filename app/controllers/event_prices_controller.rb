class EventPricesController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_user_buffet_owner, only: [:new, :create, :edit, :update]
    
    def new
        @event = Event.find(params[:event_id])
        @event_price = EventPrice.new
    end

    def create
        @event = Event.find(params[:event_id])
        @event_price = EventPrice.new(event_price_params)
        @event_price.event_id = @event.id
        if @event_price.save
            redirect_to root_path, notice: 'Preço do evento foi cadastrado com sucesso.'
        else
            flash.now[:notice] = 'Não foi possível cadastrar o preço do evento.'
            render :new
        end
    end

    def edit
        @event = Event.find_by(params[:event_id])
        @event_price = EventPrice.find(params[:id])
    end

    def update
        @event = Event.find_by(id: params[:event_id])
        @event_price = EventPrice.find(params[:id])
      
        if @event_price.update(event_price_params)
          redirect_to buffet_profile_path(current_user.buffet), notice: 'Preço do evento foi atualizado com sucesso.'
        else
          flash.now[:notice] = 'Não foi possível atualizar o preço do evento.'
          flash.now[:error] = @event_price.errors.full_messages.join(", ")
          render :edit
        end
    end

    private

    def event_price_params
        params.require(:event_price).permit(:event_id, :wd_price, :wd_add_person_price, :wd_extra_hour_price, :we_price, :we_add_person_price, :we_extra_hour_price)
    end

    def authenticate_user_buffet_owner
        unless current_user.role == 'buffet_owner'
            redirect_to root_path, alert: 'Você não está autorizado a acessar esta página.'
        end
    end
end