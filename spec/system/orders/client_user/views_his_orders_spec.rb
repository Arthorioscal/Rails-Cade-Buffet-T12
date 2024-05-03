require 'rails_helper'

describe 'Client views his orders' do
    it 'successfully' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)
        event_price = EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
        order = Order.create!(event_date: '10/10/2099', estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)

        login_as client, scope: :user
        visit root_path
        click_on 'Meus Pedidos'

        expect(page).to have_content("Pedido: #{order.order_code}")
        expect(page).to have_content("Status do Pedido: AGUARDANDO AVALIAÇÃO")
        expect(page).to have_content("Data Estimada: 10/10/2099")
    end

    it 'successfully and see details' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)
        event_price = EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
        order = Order.create!(event_date: '10/10/2099', estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, valid_until: 7.days.from_now, extra_fee: 100, discount: 0, description: 'Festa de aniversário de 50 anos', order_payment_method: 'Cartão de Crédito', final_price: 2000)

        login_as client, scope: :user
        visit root_path
        click_on 'Meus Pedidos'
        click_on "Pedido: #{order.order_code}"

        expect(page).to have_content('Festa de Aniversário')
        expect(page).to have_content('10/10/2099')
        expect(page).to have_content('50')
        expect(page).to have_content('Festa de aniversário de 50 anos')
        expect(page).to have_content('Rua do Evento, 123')
        expect(page).to have_content('Buffet do Snake')
    end

    it 'order is confirmed by the owner' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)
        event_price = EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
        order = Order.create!(event_date: '10/10/2099', estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                                status: 1, valid_until: 7.days.from_now, extra_fee: 100, discount: 0, description: 'Festa de aniversário de 50 anos', order_payment_method: 'Cartão de Crédito', final_price: 2000)

        login_as client, scope: :user
        visit root_path
        click_on 'Meus Pedidos'

        expect(page).to have_content('Status do Pedido: CONFIRMADO PELO DONO DO BUFFET')
    end

    it 'view if the price is right for weekday without extra guests' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 50,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)
        event_price = EventPrice.create!(wd_price: 3000, wd_add_person_price: 100, wd_extra_hour_price: 400, we_price: 4500, we_add_person_price: 150, we_extra_hour_price: 800, event: event)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
        order = Order.create!(event_date: 14.days.from_now, estimated_guests: 48, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                                status: 1, valid_until: 7.days.from_now, extra_fee: 300, discount: 0, description: 'Custo extra de transporte para o local', order_payment_method: 'Cartão de Crédito', final_price: 3000)

        login_as client, scope: :user
        visit root_path
        click_on 'Meus Pedidos'
        click_on "Pedido: #{order.order_code}"

        expect(page).to have_content('Valor Total: $3,300.00')
        expect(page).to have_content('Valor do Pedido: $3,000.00')
        expect(page).to have_content('Taxa Extra: $300.00')
        expect(page).to have_content('Desconto: $0.00')
        expect(page).to have_content('Detalhes da Alteração no Valor: Custo extra de transporte para o local')
        expect(page).to have_content('Meio de Pagamento: Cartão de Crédito')
    end
end