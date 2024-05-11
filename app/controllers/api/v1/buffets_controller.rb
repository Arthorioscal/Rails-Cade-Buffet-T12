class Api::V1::BuffetsController < Api::V1::ApiController
    def index
        @buffets = Buffet.search(params[:search])
        render status: 200, json: @buffets
    end

    def show
        @buffet = Buffet.find(params[:id])
        render status: 200, json: @buffet.as_json(except: %i[corporate_name cnpj])
    end
end
