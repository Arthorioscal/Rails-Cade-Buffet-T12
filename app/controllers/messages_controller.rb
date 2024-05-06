class MessagesController < ApplicationController
    def create
        @order = Order.find(params[:order_id])
        @message = Message.new(message_params)
        @message.order = @order
        @message.user = current_user
        if @message.save
            redirect_to order_path(@order)
        else
            render 'orders/show'
        end
    end

    private

    def message_params
        params.require(:message).permit(:content)
    end
end