class EventsController < ApplicationController
    before_action :authenticate_user!
    before_action :user_not_authenticated, only: [:edit, :update]
    before_action :authenticate_user_buffet_owner, only: [:new, :create, :edit, :update, :toggle_active, :cancellation_rules,:update_cancellation_rules]

    def index
        @events = Event.where(active: true)
    end

    def show
        @event = Event.find(params[:id])
    end

    def new
        @buffet = current_user.buffet
        @event = Event.new
    end

    def create
        @buffet = current_user.buffet
        @event = Event.new(event_params)
        if @event.save
            redirect_to event_path(@event), notice: 'Tipo de evento cadastrado com sucesso.'
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
            redirect_to buffet_profile_path(current_user.buffet), notice: 'Tipo de evento atualizado com sucesso.'
        else
            flash.now[:notice] = 'Não foi possível atualizar o tipo de evento, tente novamente'
            render :edit
        end
    end

    def toggle_active
        @event = Event.find(params[:id])
        @event.toggle!(:active)
        redirect_to buffet_profile_path(current_user.buffet), notice: 'Status do tipo de evento atualizado com sucesso.'
    end

    def cancellation_rules
        @event = Event.find(params[:id])
    end

    def update_cancellation_rules
        @event = Event.find(params[:id])
        if @event.update(event_params)
            redirect_to buffet_profile_path(current_user.buffet), notice: 'Regras de cancelamento atualizadas com sucesso.'
        else
            flash.now[:notice] = 'Não foi possível atualizar as regras de cancelamento, tente novamente'
            render :show
        end
    end

    private

    def event_params
        params.require(:event).permit(:name, :description, :min_people, :max_people, :duration, :menu, :alcohol, :decoration, :parking_service, :at_buffet_location, :buffet_id, :partial_cancellation_fine, :total_cancellation_days, :total_cancellation_fine, :partial_cancellation_days, photos: [])    
    end

    def user_not_authenticated
        @event = Event.find(params[:id])
        if @event.buffet.user != current_user
            redirect_to root_path, notice: 'Você não tem permissão para acessar essa página'
        end
    end

    def authenticate_user_buffet_owner
        unless current_user.role == 'buffet_owner'
            redirect_to root_path, alert: 'Você não está autorizado a acessar esta página.'
        end
    end
end