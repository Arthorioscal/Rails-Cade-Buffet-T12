class FinesController < ApplicationController
    before_action :authenticate_user!

    def show
        @fine = Fine.find(params[:id])
    end
    
    def update
        @fine = Fine.find_by(order_id: params[:order_id])
        if current_user.role == 'buffet_owner' && @fine.update(status: 'paid')
            redirect_to buffet_buffet_order_path(@fine.order), notice: 'Pagamento da multa confirmado com sucesso'
        else
            flash.now[:notice] = 'Não foi possível confirmar o pagamento da multa, tente novamente'
            render :show
        end
    end
end