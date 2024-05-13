class Api::V1::BuffetsController < Api::V1::ApiController
    include Rails.application.routes.url_helpers

    def index
        @buffets = Buffet.search(params[:search])
        buffets_with_photos = @buffets.map do |buffet|
            buffet.as_json.merge({ cover_photo: buffet.cover_photo.attached? ? url_for(buffet.cover_photo) : nil })
        end
        render status: 200, json: buffets_with_photos
    end

    def show
        @buffet = Buffet.find(params[:id])
        render status: 200, json: @buffet.as_json(except: %i[corporate_name cnpj]).merge({ cover_photo: @buffet.cover_photo.attached? ? url_for(@buffet.cover_photo) : nil })
    end
end