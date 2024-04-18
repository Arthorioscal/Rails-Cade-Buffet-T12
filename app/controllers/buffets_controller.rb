class BuffetsController < ApplicationController
    def new
        @buffet = Buffet.new
    end

    def create
        @buffet = Buffet.new(buffet_params)
        @buffet.user = current_user
        if @buffet.save
            redirect_to root_path, notice: 'Buffet cadastrado com sucesso.'
        else
            puts @buffet.errors.full_messages
            flash.now[:notice] = 'Não foi possível cadastrar o buffet, tente novamente'
            render :new
        end
    end

    private

    def buffet_params
        params.require(:buffet).permit(:brand_name, :corporate_name, :cnpj, :phone, :email, :address, :neighborhood, :state, :city, :zip_code, :description, :payment_methods)
    end
end