require 'rails_helper'

describe 'Client user cancels confirmed order' do
    it 'successfully and sees the fine' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet, partial_cancellation_fine: 0.1, partial_cancellation_days: 20, total_cancellation_fine: 0.2, total_cancellation_days: 2)
        EventPrice.create!(wd_price: 2000, wd_add_person_price: 50, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
        order = Order.create!(event_date: 10.days.from_now, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                            status: 2, valid_until: 3.days.from_now, extra_fee: 100, discount: 0, description: 'Festa de aniversário de 50 anos é mais caro', order_payment_method: 'Cartão de Crédito', final_price: 2600)
        
        login_as client, scope: :user
        visit root_path
        click_on 'Meus Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Cancelar Pedido'

        expect(page).to have_content('Você tem certeza que deseja cancelar esse pedido?')
        expect(page).to have_content('Valor da Multa: $260.00')
        expect(page).to have_button('Cancelar Pedido')
    end
    
    it 'sucessfully cancels' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet, partial_cancellation_fine: 0.1, partial_cancellation_days: 20, total_cancellation_fine: 0.2, total_cancellation_days: 2)
        EventPrice.create!(wd_price: 2000, wd_add_person_price: 50, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
        order = Order.create!(event_date: 10.days.from_now, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                            status: 2, valid_until: 3.days.from_now, extra_fee: 100, discount: 0, description: 'Festa de aniversário de 50 anos é mais caro', order_payment_method: 'Cartão de Crédito', final_price: 2600)
        
        login_as client, scope: :user
        visit root_path
        click_on 'Meus Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Cancelar Pedido'
        click_on 'Cancelar Pedido'

        expect(page).to have_content('Status: Cancelado')
    end

    it 'cancels but the fines doesnt apply to him' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet, partial_cancellation_fine: 0.1, partial_cancellation_days: 20, total_cancellation_fine: 0.2, total_cancellation_days: 2)
        EventPrice.create!(wd_price: 2000, wd_add_person_price: 50, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
        order = Order.create!(event_date: 22.days.from_now, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                            status: 2, valid_until: 10.days.from_now, extra_fee: 100, discount: 0, description: 'Festa de aniversário de 50 anos é mais caro', order_payment_method: 'Cartão de Crédito', final_price: 2600)
        
        login_as client, scope: :user
        visit root_path
        click_on 'Meus Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Cancelar Pedido'

        expect(page).to have_content('Você tem certeza que deseja cancelar esse pedido?')
        expect(page).to have_content('As regras de multa não se aplicam a você.')
        expect(page).to have_button('Cancelar Pedido')
    end
end