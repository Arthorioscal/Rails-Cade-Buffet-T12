require 'rails_helper'

describe 'Client views buffets' do
    it 'and sees all buffets from the homepage' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)

        login_as client, scope: :user
        visit root_path

        expect(page).to have_content('Bem vindo ao Cade Buffet!')
        expect(page).to have_content('Buffet do Snake')
        expect(page).to have_content('São Paulo - São Paulo')
        expect(page).to have_content('Rua do Buffet, 123')
    end

    it 'and sees buffet details' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
        EventPrice.create!(wd_price: 2000, wd_add_person_price: 50, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)

        login_as client, scope: :user
        visit root_path
        click_on 'Ver Detalhes'

        expect(page).to have_content('Buffet do Snake')
        expect(page).to have_content('45195101000101')
        expect(page).to have_content('11999999999')
        expect(page).to have_content('solidsnakefans@mail.com')
        expect(page).to have_content('Rua do Buffet, 123')
        expect(page).to have_content('Bairro do Buffet')
        expect(page).to have_content('São Paulo')
        expect(page).to have_content('São Paulo')
        expect(page).to have_content('12345678')
        expect(page).to have_content('Buffet especializado em festas de aniversário')
        expect(page).to have_content('Dinheiro, cartão de crédito e débito')
        expect(page).to have_content('Festa de Aniversário')
        expect(page).to have_content('Festa de aniversário com bolo, doces e salgados')
        expect(page).to have_content('40')
        expect(page).to have_content('100')
        expect(page).to have_content('180')
        expect(page).to have_content('Bolo, doces, salgados, refrigerante, vinho')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Preço do evento mínimo: 2000.0')
    end

    it 'and cannot view deactivated buffet' do 
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
        EventPrice.create!(wd_price: 2000, wd_add_person_price: 50, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
        owner2 = User.create!(email: 'ezioauditore@creed.com', password: 'assassinscreed', role: :buffet_owner)
        buffet2 = Buffet.create!(brand_name: 'Auditore Festas', corporate_name: 'Assassins Buffets Ltda', cnpj: '93125160000148', phone: '11999999988', email: 'auditore@buffet.com',
            address: 'Rua dos Buffets, 123', neighborhood: 'Firenze', state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '96213100', description: 'Buffet especializado em culinária Italiana a moda da renascença, com foco em festas corporativas',
            payment_methods: 'Dinheiro, Pix, cartão de crédito e débito', user: owner2)
        event3 = Event.create!(name: 'Festa Corporativa', description: 'Festa corporativa com pratos italianos', min_people: 50, max_people: 200, duration: 240,
            menu: 'Pratos italianos, vinho, cerveja', alcohol: true, decoration: true, parking_service: false, at_buffet_location: true, buffet: buffet2)
            EventPrice.create!(wd_price: 3000, wd_add_person_price: 100, wd_extra_hour_price: 1000, we_price: 4000, we_add_person_price: 120, we_extra_hour_price: 1000, event: event3)
        buffet.update(active: false)

        login_as client, scope: :user
        visit root_path
        
        expect(page).to have_content('Bem vindo ao Cade Buffet!')
        expect(page).to have_content('Auditore Festas')
        expect(page).not_to have_content('Buffet do Snake')
    end

    it 'and tries to search for deactivated buffet' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
        EventPrice.create!(wd_price: 2000, wd_add_person_price: 50, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
        owner2 = User.create!(email: 'ezioauditore@creed.com', password: 'assassinscreed', role: :buffet_owner)
        buffet2 = Buffet.create!(brand_name: 'Auditore Festas', corporate_name: 'Assassins Buffets Ltda', cnpj: '93125160000148', phone: '11999999988', email: 'auditore@buffet.com',
            address: 'Rua dos Buffets, 123', neighborhood: 'Firenze', state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '96213100', description: 'Buffet especializado em culinária Italiana a moda da renascença, com foco em festas corporativas',
            payment_methods: 'Dinheiro, Pix, cartão de crédito e débito', user: owner2)
        event3 = Event.create!(name: 'Festa Corporativa', description: 'Festa corporativa com pratos italianos', min_people: 50, max_people: 200, duration: 240,
            menu: 'Pratos italianos, vinho, cerveja', alcohol: true, decoration: true, parking_service: false, at_buffet_location: true, buffet: buffet2)
            EventPrice.create!(wd_price: 3000, wd_add_person_price: 100, wd_extra_hour_price: 1000, we_price: 4000, we_add_person_price: 120, we_extra_hour_price: 1000, event: event3)
        buffet.update(active: false)

        login_as client, scope: :user
        visit root_path
        fill_in 'Buscar Buffet', with: 'Buffet do Snake'
        click_on 'Buscar'

        expect(page).to have_content('Resultados da busca por: Buffet do Snake')
        expect(page).to have_content('Nenhum buffet encontrado')
    end

    it 'and trie to see details and has an event deactivated' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
        event2 = Event.create!(name: 'Festa de Casamento', description: 'Festa de casamento com bolo, doces e salgados', min_people: 40,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet, active: false)
        EventPrice.create!(wd_price: 2000, wd_add_person_price: 50, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)
        EventPrice.create!(wd_price: 3000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 3500, we_add_person_price: 90, we_extra_hour_price: 150, event: event2)
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)
 
        login_as client, scope: :user
        visit root_path
        click_on 'Ver Detalhes'

        expect(page).to have_content('Buffet do Snake')
        expect(page).to have_content('45195101000101')
        expect(page).to have_content('11999999999')
        expect(page).to have_content('solidsnakefans@mail.com')
        expect(page).to have_content('Rua do Buffet, 123')
        expect(page).to have_content('Bairro do Buffet')
        expect(page).to have_content('São Paulo')
        expect(page).to have_content('São Paulo')
        expect(page).to have_content('12345678')
        expect(page).to have_content('Buffet especializado em festas de aniversário')
        expect(page).to have_content('Dinheiro, cartão de crédito e débito')
        expect(page).to have_content('Festa de Aniversário')
        expect(page).to have_content('Festa de aniversário com bolo, doces e salgados')
        expect(page).to have_content('40')
        expect(page).to have_content('100')
        expect(page).to have_content('180')
        expect(page).to have_content('Bolo, doces, salgados, refrigerante, vinho')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Preço do evento mínimo: 2000.0')
        expect(page).not_to have_content('Festa de Casamento')
        expect(page).not_to have_content('Festa de casamento com bolo, doces e salgados')
        expect(page).not_to have_content('Preço do evento mínimo: 3000.0')
    end
end