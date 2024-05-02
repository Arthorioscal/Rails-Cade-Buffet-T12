class OrdersController < ApplicationController
    before_action :authenticate_user!

    def index
        @orders = current_user.orders
    end
    
    def show
        @order = Order.find(params[:id])
    end

    def new
        @event = Event.find_by(id: params[:event_id])
        @order = Order.new
    end

    def buffet_confirmation_form
        @order = Order.find(params[:id])
    end

    def buffet_confirmation
        @order = Order.find(params[:id])
        if @order.update(order_params.merge(status: 'confirmed'))
          redirect_to buffet_buffet_orders_path(@order.buffet), notice: 'Pedido confirmado com sucesso'
        else
          flash.now[:notice] = 'Não foi possível confirmar o pedido, tente novamente'
          render :edit
        end
    end

    def create 
        @event = Event.find_by(id: params[:order][:event_id])
        @order = Order.new(order_params)
        @order.user = current_user # set the user to the currently logged in user
        if @order.event_address.blank? && @order.event.at_buffet_location == true
            @order.errors.add(:event_address, "deve ser preenchido se o evento for fora do buffet")
            render :new
        elsif @order.save
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