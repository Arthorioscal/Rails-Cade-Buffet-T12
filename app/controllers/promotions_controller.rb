class PromotionsController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_user_buffet_owner

    def new
        @promotion = Promotion.new
        @event = Event.find_by(id: params[:event_id])
    end

    def create
        @promotion = Promotion.new(promotion_params)
        @event = Event.find_by(id: params[:event_id])
        @promotion.event_id = params[:event_id]
        if @promotion.save
            redirect_to buffet_profile_path(current_user), bnotice: 'Promoção criada com sucesso'
        else
            flash.now[:notice] = 'Não foi possível criar a promoção'
            render :new
        end
    end

    def destroy
        @promotion = Promotion.find(params[:id])
        @promotion.destroy
        redirect_to buffet_profile_path(current_user), notice: 'Promoção excluída com sucesso'
    end

    private

    def promotion_params
        params.require(:promotion).permit(:name, :start_date, :end_date, :event_id, :weekday_discount, :weekend_discount)
    end

    def authenticate_user_buffet_owner
        unless current_user.role == 'buffet_owner'
            redirect_to root_path, notice: 'Você não tem permissão para acessar essa página'
        end
    end
end