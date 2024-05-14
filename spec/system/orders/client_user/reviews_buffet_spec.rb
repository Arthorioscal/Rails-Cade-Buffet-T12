require 'rails_helper'

describe 'Client reviews buffet' do
    it 'successfully' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 50,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)
        EventPrice.create!(wd_price: 3000, wd_add_person_price: 100, wd_extra_hour_price: 400, we_price: 4500, we_add_person_price: 150, we_extra_hour_price: 800, event: event)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
        Order.create!(event_date: 14.days.from_now, estimated_guests: 48, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                                status: 2, valid_until: 7.days.from_now, extra_fee: 300, discount: 0, description: 'Custo extra de transporte para o local', order_payment_method: 'Cartão de Crédito', final_price: 3000)

        travel_to 15.days.from_now do
            login_as client, scope: :user
            visit root_path
            click_on 'Meus Pedidos'
            click_on 'Avaliar Buffet'
            fill_in 'Nota', with: 5
            fill_in 'Comentário', with: 'Buffet maravilhoso, recomendo a todos!'
            click_on 'Enviar Avaliação'

            expect(page).to have_content('Avaliação enviada com sucesso.')
            expect(page).to have_content('Buffet do Snake')
            expect(page).to have_content('Nota do Buffet: 5.0')
        end
    end

    it 'and it has multiple reviews' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 50,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)
        EventPrice.create!(wd_price: 3000, wd_add_person_price: 100, wd_extra_hour_price: 400, we_price: 4500, we_add_person_price: 150, we_extra_hour_price: 800, event: event)
        Review.create!(rating: 4, comment: 'Buffet maravilhoso, recomendo a todos!', user: user, buffet: buffet)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
        Order.create!(event_date: 14.days.from_now, estimated_guests: 48, details: 'Festa de aniversário de 50 anos', event_address: 'Rua do Evento, 123', buffet: buffet, event: event, user: client, 
                                status: 2, valid_until: 7.days.from_now, extra_fee: 300, discount: 0, description: 'Custo extra de transporte para o local', order_payment_method: 'Cartão de Crédito', final_price: 3000)

        travel_to 15.days.from_now do
            login_as client, scope: :user
            visit root_path
            click_on 'Meus Pedidos'
            click_on 'Avaliar Buffet'
            fill_in 'Nota', with: 5
            fill_in 'Comentário', with: 'Buffet maravilhoso, recomendo a todos!'
            click_on 'Enviar Avaliação'

            expect(page).to have_content('Avaliação enviada com sucesso.')
            expect(page).to have_content('Buffet do Snake')
            expect(page).to have_content('Nota do Buffet: 4.5')
        end
    end

    it 'see reviews from other clients' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        client1 = User.create!(email: 'clienteteste@mail.com', password: 'teste123', name: 'Cliente Teste', cpf: '12552367011', role: :client)
        client2 = User.create!(email: 'ocritico@critico.com', password: 'eucriticobuffets', name: 'O crítico', cpf: '03483774017', role: :client)
        client3 = User.create!(email: 'captainprice@sas.com', password: 'callofdutymw', name: 'Captain Price', cpf: '41135177031', role: :client)
        client4 = User.create!(email: 'alberteinstein@physics.com', password: 'ilovephysics', name: 'Albert Einstein', cpf: '79912834020', role: :client)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 50,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)
        EventPrice.create!(wd_price: 3000, wd_add_person_price: 100, wd_extra_hour_price: 400, we_price: 4500, we_add_person_price: 150, we_extra_hour_price: 800, event: event)
        Review.create!(rating: 4, comment: 'Buffet maravilhoso, recomendo a todos!', user: client1, buffet: buffet)
        Review.create!(rating: 5, comment: 'Buffet maravilhoso, recomendo a todos!', user: client2, buffet: buffet)
        Review.create!(rating: 3, comment: 'Buffet maravilhoso, recomendo a todos!', user: client3, buffet: buffet)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)

        login_as client, scope: :user
        visit root_path
        click_on 'Ver Detalhes'
        
        expect(page).to have_content('Avaliações do Buffet')
        expect(page).to have_content("Usuário: #{client1.name}")
        expect(page).to have_content('Nota: 4')
        expect(page).to have_content('Comentário: Buffet maravilhoso, recomendo a todos!')
        expect(page).to have_content("Usuário: #{client2.name}")
        expect(page).to have_content('Nota: 5')
        expect(page).to have_content('Comentário: Buffet maravilhoso, recomendo a todos!')
        expect(page).to have_content("Usuário: #{client3.name}")
        expect(page).to have_content('Nota: 4')
    end

    it 'see all reviews inside the index' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        client1 = User.create!(email: 'clienteteste@mail.com', password: 'teste123', name: 'Cliente Teste', cpf: '12552367011', role: :client)
        client2 = User.create!(email: 'ocritico@critico.com', password: 'eucriticobuffets', name: 'O crítico', cpf: '03483774017', role: :client)
        client3 = User.create!(email: 'captainprice@sas.com', password: 'callofdutymw', name: 'Captain Price', cpf: '41135177031', role: :client)
        client4 = User.create!(email: 'alberteinstein@physics.com', password: 'ilovephysics', name: 'Albert Einstein', cpf: '79912834020', role: :client)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 50,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)
        EventPrice.create!(wd_price: 3000, wd_add_person_price: 100, wd_extra_hour_price: 400, we_price: 4500, we_add_person_price: 150, we_extra_hour_price: 800, event: event)
        Review.create!(rating: 4, comment: 'Buffet maravilhoso, recomendo a todos!', user: client1, buffet: buffet)
        Review.create!(rating: 5, comment: 'Buffet maravilhoso, recomendo a todos!', user: client2, buffet: buffet)
        Review.create!(rating: 3, comment: 'Buffet maravilhoso, recomendo a todos!', user: client3, buffet: buffet)
        Review.create!(rating: 5, comment: 'Buffet maravilhoso, recomendo a todos!', user: client4, buffet: buffet)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)

        login_as client, scope: :user
        visit root_path
        click_on 'Ver Detalhes'
        click_on 'Ver mais Avaliações'

        expect(page).to have_content('Avaliações do Buffet')
        expect(page).to have_content("Usuário: #{client1.name}")
        expect(page).to have_content('Nota: 4')
        expect(page).to have_content('Comentário: Buffet maravilhoso, recomendo a todos!')
        expect(page).to have_content("Usuário: #{client2.name}")
        expect(page).to have_content('Nota: 5')
        expect(page).to have_content('Comentário: Buffet maravilhoso, recomendo a todos!')
        expect(page).to have_content("Usuário: #{client3.name}")
        expect(page).to have_content('Nota: 4')
        expect(page).to have_content("Usuário: #{client4.name}")
        expect(page).to have_content('Nota: 5')
    end
end
