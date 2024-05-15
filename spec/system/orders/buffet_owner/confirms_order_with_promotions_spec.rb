require 'rails_helper'

describe 'Buffet owner confirms order with promotions' do
    it 'successfully out of the promotion end date' do
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
        order = Order.create!(event_date: 12.days.from_now, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)
        Promotion.create!(name: 'DEU A LOCA NO DONO', start_date: 1.day.from_now, end_date: 10.days.from_now, weekday_discount: 0.1, weekend_discount: 0.05, event: event)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Confirmar Pedido'
        fill_in 'Data de validade para confirmação', with: 4.days.from_now
        fill_in 'Descrição caso ocorra alteração no valor:', with: 'tudo certo'
        fill_in 'Meio de Pagamento', with: 'pix'
        click_on 'Confirmar Pedido'
        click_on "Pedido: #{order.order_code}"

        expect(page).to have_content('Valor Total: $2,700.00')
        expect(page).to have_content('Preço do Pedido (sem acréscimo): $2,700.00')
    end

    it 'successfully confirms an ordern with a promotion' do
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
        order = Order.create!(event_date: 6.days.from_now, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)
        Promotion.create!(name: 'DEU A LOCA NO DONO', start_date: 1.day.from_now, end_date: 10.days.from_now, weekday_discount: 0.1, weekend_discount: 0.05, event: event)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Confirmar Pedido'
        fill_in 'Data de validade para confirmação', with: 3.days.from_now
        fill_in 'Descrição caso ocorra alteração no valor:', with: 'tudo certo'
        fill_in 'Meio de Pagamento', with: 'pix'
        click_on 'Confirmar Pedido'
        click_on "Pedido: #{order.order_code}"

        expect(page).to have_content('Valor Total: $2,500.00')
        expect(page).to have_content('Preço do Pedido (sem acréscimo): $2,500.00')
    end
end