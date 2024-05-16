require 'rails_helper'

describe 'Buffet owner confirms cancel fee payment' do
    it 'sucessfully sees the payment fee' do
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
        order = Order.create!(event_date: Time.now.beginning_of_week + 7.days, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                            status: 3, valid_until: 1.days.from_now, extra_fee: 100, discount: 0, description: 'Festa de aniversário de 50 anos é mais caro', order_payment_method: 'Cartão de Crédito', final_price: 2600)
        Fine.create!(amount: 260, order: order, status: 'unpaid')

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'
        click_on "Pedido: #{order.order_code}"

        expect(page).to have_content('Status: CANCELADO')
        expect(page).to have_content('Multa à ser paga: 260.0')
        expect(page).to have_content('Status da multa: Não Pago')
        expect(page).to have_button('Confirmar Pagamento')
    end

    it 'sucessfully confirms payment' do
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
        order = Order.create!(event_date: Time.now.beginning_of_week + 7.days, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                            status: 3, valid_until: 1.days.from_now, extra_fee: 100, discount: 0, description: 'Festa de aniversário de 50 anos é mais caro', order_payment_method: 'Cartão de Crédito', final_price: 2600)
        Fine.create!(amount: 260, order: order, status: 'unpaid')

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Confirmar Pagamento'

        expect(page).to have_content('Status: CANCELADO')
        expect(page).to have_content('Multa à ser paga: 260.0')
        expect(page).to have_content('Status da multa: Pago')
        expect(page).to have_no_button('Confirmar Pagamento')
    end

    it 'views cancelled orders' do
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
        order = Order.create!(event_date: Time.now.beginning_of_week + 7.days, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                            status: 3, valid_until: 1.days.from_now, extra_fee: 100, discount: 0, description: 'Festa de aniversário de 50 anos é mais caro', order_payment_method: 'Cartão de Crédito', final_price: 2600)
        Fine.create!(amount: 260, order: order, status: 'paid')

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'

        expect(page).to have_content("Pedido: #{order.order_code}")
        expect(page).to have_content('Status do Pedido: Cancelado')
        expect(page).to have_content("Pedido: #{order.order_code} - Status da Multa = Pago")
    end
end