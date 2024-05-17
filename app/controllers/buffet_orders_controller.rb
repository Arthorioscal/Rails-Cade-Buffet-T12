class BuffetOrdersController < ApplicationController
    before_action :set_buffet
    before_action :authenticate_user_buffet_owner

    def index
        @orders = @buffet.orders.group_by(&:status)
    end

    def show
        @order = @buffet.orders.find(params[:id])
        if @buffet.orders.where(event_date: @order.event_date).where.not(id: @order.id).exists?
            flash[:notice] = "Tem um outro pedido para essa mesma data."
        end
    end

    private

    def set_buffet
        @buffet = Buffet.find(params[:buffet_id])
    end

    def authenticate_user_buffet_owner
        unless current_user.role == 'buffet_owner'
            redirect_to root_path, alert: 'Você não está autorizado a acessar esta página.'
        end
    end
end