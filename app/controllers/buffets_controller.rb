class BuffetsController < ApplicationController
    before_action :authenticate_user!, only: [:profile, :new, :create, :edit, :update]
    before_action :user_not_authenticated, only: [:edit, :update]

    
    def show
        @buffet = Buffet.find(params[:id])
    end
    
    def profile
        @buffet = current_user.buffet
        @event_prices = @buffet.events.map(&:event_price)
    end
    
    def search
        @query = params[:query]
        @buffets = Buffet.where(active: true).joins(:events).distinct
        .where("buffets.brand_name LIKE :query OR buffets.city LIKE :query OR events.name LIKE :query", query: "%#{@query}%")
        .order(:name)
    end
    
    def new
        @buffet = Buffet.new
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

    def toggle_active
        @buffet = Buffet.find(params[:id])
        @buffet.toggle!(:active)
        redirect_to buffet_profile_path(@buffet), notice: 'Status do buffet atualizado com sucesso.'
    end

    private

    def buffet_params
        params.require(:buffet).permit(:brand_name, :corporate_name, :cnpj, :phone, :email, :address, :neighborhood, :state, :city, :zip_code, :description, :payment_methods, :cover_photo)
    end

    def user_not_authenticated
        @buffet = Buffet.find(params[:id])
        if @buffet.user != current_user
            redirect_to root_path, notice: 'Você não tem permissão para acessar essa página'
        end        
    end
end