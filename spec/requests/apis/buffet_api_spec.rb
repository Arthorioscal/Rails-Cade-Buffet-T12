require 'rails_helper'

describe 'Buffet API' do
    context 'GET /api/v1/buffets' do
        it 'successfully get the index by name' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
            event_price = EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)

            get "/api/v1/buffets", params: { search: buffet.brand_name }

            expect(response).to have_http_status(200) 
            expect(response.content_type).to include('application/json')
            json_response = JSON.parse(response.body, symbolize_names: true)
            json_response.each do |buffet|
                expect(buffet[:brand_name]).to eq('Buffet do Snake')
                expect(buffet[:corporate_name]).to eq('Buffet do Snake Ltda')
                expect(buffet[:cnpj]).to eq('45195101000101')
                expect(buffet[:phone]).to eq('11999999999')
                expect(buffet[:email]).to eq('solidsnakefans@mail.com')
                expect(buffet[:address]).to eq('Rua do Buffet, 123')
            end
        end
        
        it 'successfully show the buffet' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
            event_price = EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)

            get "/api/v1/buffets/#{buffet.id}"

            expect(response).to have_http_status(200)
            expect(response.content_type).to include('application/json')
            json_response = JSON.parse(response.body, symbolize_names: true) 
            expect(json_response[:brand_name]).to eq('Buffet do Snake')
            expect(json_response[:phone]).to eq('11999999999')
            expect(json_response[:email]).to eq('solidsnakefans@mail.com')
            expect(json_response[:address]).to eq('Rua do Buffet, 123')
            expect(json_response[:neighborhood]).to eq('Bairro do Buffet')
            expect(json_response[:state]).to eq('São Paulo')
            expect(json_response[:city]).to eq('São Paulo')
            expect(json_response[:zip_code]).to eq('12345678')
            expect(json_response[:description]).to eq('Buffet especializado em festas de aniversário')
            expect(json_response[:payment_methods]).to eq('Dinheiro, cartão de crédito e débito')
            expect(json_response).not_to include(:cnpj)
            expect(json_response).not_to include(:corporate_name)
        end
    end
end