require 'rails_helper'

RSpec.describe Order, type: :model do
    context 'validation' do
        it 'attributes cannot be blank' do
            order = Order.new
        
            order.valid?
        
            expect(order.errors[:event_date]).to include('Informe a data do evento')
            expect(order.errors[:estimated_guests]).to include('Informe o número de convidados')
            expect(order.errors[:details]).to include('Informe os detalhes do evento')
        end

        it 'estimated_guests must be greater than 0' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
            EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
            client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
            order = Order.new(event_date: 2.days.from_now, estimated_guests: 0, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)

            order.valid?

            expect(order).to_not be_valid
            expect(order.errors[:estimated_guests]).to include('Número de convidados deve ser maior que zero')
        end
        
        it 'order_code must be unique' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
            EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
            client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
            order1 = Order.create!(event_date: 2.days.from_now, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)
            order2 = Order.create!(event_date: 3.days.from_now, estimated_guests: 60, details: 'Festa de aniversário de 60 anos', event_address: 'Rua do Evento, 456', buffet: buffet, event: event, user: client)
        
            order2.valid?
        
            expect(order1.order_code).to_not eq(order2.order_code)
        end


    end
end
