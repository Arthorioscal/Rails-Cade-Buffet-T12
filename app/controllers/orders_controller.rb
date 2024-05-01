class OrdersController < ApplicationController
    before_action :authenticate_user!

    def index
        @orders = current_user.orders
    end
    
    def show
        @order = Order.find(params[:id])
    end

    def new
        @event = Event.find(params[:event_id])
        @order = Order.new
    end

    def create 
        @event = Event.find(params[:event_id])
        @order = Order.new(order_params)
        if @order.save
            redirect_to orders_path(@order), notice: 'Pedido realizado com sucesso'
        else
            flash.now[:notice] = 'Não foi possível realizar o pedido, tente novamente'
            render :new
        end
    end

    private

    def order_params
        params.require(:order).permit(:event_date, :estimated_guests, :details, :event_address, :buffet_id, :event_id)
    end
end