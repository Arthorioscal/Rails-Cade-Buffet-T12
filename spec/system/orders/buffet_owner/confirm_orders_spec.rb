require 'rails_helper'

describe 'Buffet owner confirms orders' do
    it 'and see the form' do
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
        order = Order.create!(event_date: '10/10/2099', estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Confirmar Pedido'
        
        expect(page).to have_content('Valor Final')
        expect(page).to have_content('Data de validade para confirmação')
        expect(page).to have_content('Taxa Extra')
        expect(page).to have_content('Desconto')
        expect(page).to have_content('Descrição para caso ocorra alteração no valor ou não:')
        expect(page).to have_content('Meio de Pagamento')
    end

    it 'successfully' do
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
        order = Order.create!(event_date: '10/10/2099', estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Confirmar Pedido'
        fill_in 'Data de validade para confirmação', with: '10/10/2099'
        fill_in 'Taxa Extra', with: '0'
        fill_in 'Desconto', with: '200'
        fill_in 'Descrição para caso ocorra alteração no valor ou não:', with: 'Valor final com desconto de 10%'
        fill_in 'Meio de Pagamento', with: 'Cartão de Crédito ou Pix'   
        click_on 'Confirmar Pedido'

        expect(page).to have_content('Pedido confirmado com sucesso')
        expect(page).to have_content('Status do Pedido: Confirmado pelo Dono do Buffet')
    end

    it 'confirms order and see its total value inside the order' do
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
        order = Order.create!(event_date: '10/10/2099', estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Confirmar Pedido'
        fill_in 'Data de validade para confirmação', with: '10/10/2099'
        fill_in 'Taxa Extra', with: '0'
        fill_in 'Desconto', with: '200'
        fill_in 'Descrição para caso ocorra alteração no valor ou não:', with: 'Valor final com desconto de 10%'
        fill_in 'Meio de Pagamento', with: 'Cartão de Crédito ou Pix'   
        click_on 'Confirmar Pedido'
        click_on "Pedido: #{order.order_code}"

        expect(page).to have_content('Valor Total: $3,100.00')
        expect(page).to have_content('Meio de Pagamento: Cartão de Crédito ou Pix')
        expect(page).to have_content('Preço do Pedido (sem acréscimo): $3,300.00')
    end

    it 'the owner takes too long to see the order and it gets past event date' do
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
        order = Order.create!(event_date: 2.days.from_now, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)
        
        travel 3.days
        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'
        click_on "Pedido: #{order.order_code}"
        
        expect(page).not_to have_link('Confirmar Pedido')
        expect(page).to have_content('Pedido expirado.')
    end

    it 'views the final price correctly' do
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
        order = Order.create!(event_date: Date.today.next_weekday, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Confirmar Pedido'
        fill_in 'Data de validade para confirmação', with: 2.days.from_now
        fill_in 'Descrição para caso ocorra alteração no valor ou não:', with: 'tudo certo'
        fill_in 'Meio de Pagamento', with: 'pix'
        click_on 'Confirmar Pedido'
        click_on "Pedido: #{order.order_code}"

        expect(page).to have_content('Valor Total: $2,700.00')
        expect(page).to have_content('Preço do Pedido (sem acréscimo): $2,700.00')
    end

    it 'views the final price correctly its weekends price' do
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
        order = Order.create!(event_date: Date.today.next_occurring(:saturday), estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Confirmar Pedido'
        fill_in 'Data de validade para confirmação', with: 5.days.from_now
        fill_in 'Descrição para caso ocorra alteração no valor ou não:', with: 'tudo certo'
        fill_in 'Meio de Pagamento', with: 'pix'
        click_on 'Confirmar Pedido'
        click_on "Pedido: #{order.order_code}"

        expect(page).to have_content('Valor Total: $3,300.00')
        expect(page).to have_content('Preço do Pedido (sem acréscimo): $3,300.00')
    end

    it 'views price correctly on weekend with extra fee' do
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
        order = Order.create!(event_date: Time.now.beginning_of_week + 12.days, estimated_guests: 50, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Pedidos'
        click_on "Pedido: #{order.order_code}"
        click_on 'Confirmar Pedido'
        fill_in 'Data de validade para confirmação', with: 5.days.from_now
        fill_in 'Taxa Extra', with: '100'
        fill_in 'Descrição para caso ocorra alteração no valor ou não:', with: 'é aniversario do meu tio esse dia'
        fill_in 'Meio de Pagamento', with: 'pix'
        click_on 'Confirmar Pedido'
        click_on "Pedido: #{order.order_code}"

        expect(page).to have_content('Valor Total: $3,400.00')
        expect(page).to have_content('Preço do Pedido (sem acréscimo): $3,300.00')
    end
end