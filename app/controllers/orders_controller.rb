class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_user_client, only: [:new, :create]
    before_action :authenticate_user_buffet, only: [:buffet_confirmation_form, :buffet_confirmation]


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
        if @order.update(order_params.merge(status: 'confirmed_by_owner'))
          redirect_to buffet_buffet_orders_path(@order.buffet), notice: 'Pedido confirmado com sucesso'
        else
          flash.now[:notice] = 'Não foi possível confirmar o pedido, tente novamente'
          render :buffet_confirmation_form
        end
    end

    def client_confirmation
        @order = Order.find(params[:id])
        @order.update(status: 2)
        redirect_to orders_path(@order), notice: 'Pedido confirmado com sucesso'
    end

    def create 
        @event = Event.find_by(id: params[:order][:event_id])
        @order = Order.new(order_params)
        @order.user = current_user
        if @order.event_address.blank? && @order.event.at_buffet_location == true
            @order.errors.add(:event_address, "adicione informações no campo")
            render :new
        elsif @order.save
            redirect_to orders_path(@order), notice: 'Pedido realizado com sucesso'
        else
            flash.now[:notice] = 'Não foi possível realizar o pedido, tente novamente'
            render :new
        end
    end

    def cancel_confirmation
        @order = Order.find(params[:id])
        days_remaining = (@order.event_date - Date.today).to_i
        if @order.event.partial_cancellation_fine.present?
          if days_remaining <= @order.event.partial_cancellation_days  && days_remaining > @order.event.total_cancellation_days
            @cancellation_fee = (@order.final_price * @order.event.partial_cancellation_fine)
          elsif days_remaining < @order.event.partial_cancellation_days && days_remaining <= @order.event.total_cancellation_days
            @cancellation_fee = @order.final_price * @order.event.total_cancellation_fine
          end
        end
    end

    def cancel
        @order = Order.find(params[:id])
        cancellation_fee = params[:cancellation_fee]
        if @order.update(status: 'cancelled')
            Fine.create(order: @order, amount: cancellation_fee, status: 'unpaid')
            redirect_to @order, notice: 'Tipo de evento atualizado com sucesso.'
        else
            flash.now[:notice] = 'Não foi possível atualizar o tipo de evento, tente novamente'
            render :cancel_confirmation
        end
    end

    private

    def order_params
        params.require(:order).permit(:event_date, :estimated_guests, :details, :event_address, :buffet_id, :event_id, :final_price, :valid_until, :extra_fee, :discount, :description, :order_payment_method)
    end

    def authenticate_user_client
        redirect_to root_path, notice: 'Acesso não autorizado' unless current_user.role == 'client'
    end

    def authenticate_user_buffet
        redirect_to root_path, notice: 'Acesso não autorizado' unless current_user.role == 'buffet_owner'
    end
end