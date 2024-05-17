class FinesController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_user_buffet_owner, only: [:update]
    
    def update
        @fine = Fine.find_by(order_id: params[:order_id])
        if current_user.role == 'buffet_owner' && @fine.update(status: 'paid')
            redirect_to buffet_buffet_order_path(@fine.order), notice: 'Pagamento da multa confirmado com sucesso'
        else
            flash.now[:notice] = 'Não foi possível confirmar o pagamento da multa, tente novamente'
            render :show
        end
    end

    def authenticate_user_buffet_owner
        unless current_user.role == 'buffet_owner'
            redirect_to root_path, alert: 'Você não está autorizado a acessar esta página.'
        end
    end
end