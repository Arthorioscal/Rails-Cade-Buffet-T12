require 'rails_helper'

describe 'Event API' do
    context 'GET /api/v1/events' do
        it 'successfully get the buffet events' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
            EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)

            get "/api/v1/buffets/#{buffet.id}/events"

            expect(response).to have_http_status(200)
            expect(response.content_type).to include('application/json')
            json_response = JSON.parse(response.body, symbolize_names: true)
            json_response.each do |event|
                expect(event[:name]).to eq('Festa de Aniversário')
                expect(event[:description]).to eq('Festa de aniversário com bolo, doces e salgados')
                expect(event[:min_people]).to eq(40)
                expect(event[:max_people]).to eq(100)
                expect(event[:duration]).to eq(180)
                expect(event[:menu]).to eq('Bolo, doces, salgados, refrigerante, vinho')
                expect(event[:alcohol]).to eq("Sim")
                expect(event[:decoration]).to eq("Sim")
                expect(event[:parking_service]).to eq("Sim")
                expect(event[:at_buffet_location]).to eq("Sim")
            end
        end

        it 'doent get events that are deactivated' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
            EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
            event2 = Event.create!(name: 'Festa de Aniversário 2', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet, active: false)
            EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event2)

            get "/api/v1/buffets/#{buffet.id}/events"

            expect(response).to have_http_status(200)
            expect(response.content_type).to include('application/json')
            json_response = JSON.parse(response.body, symbolize_names: true)
            expect(json_response.size).to eq(1)
            expect(json_response.first[:name]).to eq('Festa de Aniversário')
        end
    end

    context 'GET /api/v1/events/:id/availability' do
        it 'successfully get the event availability' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
            EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
            client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
            Order.create!(event_date: '10/10/2099', estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                                status: 1, valid_until: 7.days.from_now, extra_fee: 100, discount: 0, description: 'Festa de aniversário de 50 anos', order_payment_method: 'Cartão de Crédito', final_price: 2000)
            
            get "/api/v1/buffets/#{buffet.id}/events/#{event.id}/availability", params: { date: '31/12/2099', guests: 50 }

            expect(response).to have_http_status(200)
            expect(response.content_type).to include('application/json')
            json_response = JSON.parse(response.body, symbolize_names: true)
            expect(json_response[:available]).to eq(true)
            expect(json_response[:final_price].to_f).to eq(4800.0)
        end

        it 'successfully get the event availability when the event is not available' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
            EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
            client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
            Order.create!(event_date: '10/10/2099', estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                                status: 1, valid_until: 7.days.from_now, extra_fee: 100, discount: 0, description: 'Festa de aniversário de 50 anos', order_payment_method: 'Cartão de Crédito', final_price: 2000)
            
            get "/api/v1/buffets/#{buffet.id}/events/#{event.id}/availability", params: { date: '10/10/2099', guests: 50 }

            expect(response).to have_http_status(200)
            expect(response.content_type).to include('application/json')
            json_response = JSON.parse(response.body, symbolize_names: true)
            expect(json_response[:available]).to eq(false)
        end
        it 'failed to get the event availability because event is not active' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet, active: false)
            EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)

            get "/api/v1/buffets/#{buffet.id}/events/#{event.id}/availability", params: { date: '10/10/2099', guests: 50 }

            expect(response).to have_http_status(404)
            expect(response.content_type).to include('application/json')
            json_response = JSON.parse(response.body, symbolize_names: true)
            expect(json_response[:message]).to eq('Event not found or not active')
        end
    end
end 