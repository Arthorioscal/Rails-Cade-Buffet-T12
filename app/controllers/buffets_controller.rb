class BuffetsController < ApplicationController
    before_action :authenticate_user!, only: [:profile, :new, :create, :edit, :update]

    def new
        @buffet = Buffet.new
    end

    def show
        @buffet = Buffet.find(params[:id])
    end

    def profile
        @buffet = current_user.buffet
        @event_prices = @buffet.events.map(&:event_price)
    end

    def create
        @buffet = Buffet.new(buffet_params)
        @buffet.user = current_user
        if @buffet.save
            redirect_to buffet_profile_path(@buffet), notice: 'Buffet cadastrado com sucesso.'
        else
            flash.now[:notice] = 'Não foi possível cadastrar o buffet, tente novamente'
            render :new
        end
    end

    def edit
        @buffet = Buffet.find(params[:id])
    end
    
    def update
        @buffet = Buffet.find(params[:id])
        if @buffet.update(buffet_params)
            redirect_to buffet_profile_path(@buffet), notice: 'Buffet atualizado com sucesso.'
        else
            flash.now[:notice] = 'Não foi possível atualizar o buffet, tente novamente'
            render :edit
        end
    end

    private

    def buffet_params
        params.require(:buffet).permit(:brand_name, :corporate_name, :cnpj, :phone, :email, :address, :neighborhood, :state, :city, :zip_code, :description, :payment_methods)
    end
end