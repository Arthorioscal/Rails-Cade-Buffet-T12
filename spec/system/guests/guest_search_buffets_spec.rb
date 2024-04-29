require 'rails_helper'

describe 'Guest search registered buffets' do
    it 'sees search field' do
        visit root_path

        expect(page).to have_field('Buscar Buffet')
    end

    it 'successfully from brand name' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        user2 = User.create!(email: 'raidenz@mgs.com', password: 'solidsnakefanz', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '89032028000114',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        buffet2 = Buffet.create!(brand_name: 'Buffet do Raiden', corporate_name: 'Buffet do Raiden Ltda', cnpj: '90626237000175',
        phone: '11999999998', email: 'raidenbuffet@email.com', address: 'Rua do Raiden, 123', neighborhood: 'Bairro do Raiden',
        state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user2)
        user3 = User.create!(email: 'snake@mgs.com', password: 'metalgearexperience', role: :buffet_owner)
        user4 = User.create!(email: 'ocelot@mgs.com', password: 'tripleagent123', role: :buffet_owner)
        buffet3 = Buffet.create!(brand_name: 'Outer Heaven Catering', corporate_name: 'Outer Heaven Events Ltda', cnpj: '16844554000105',
        phone: '11999999997', email: 'outerheaven@mail.com', address: 'Rua Outer, 123', neighborhood: 'Outer District',
        state: 'Rio de Janeiro', city: 'Rio de Janeiro', zip_code: '12345670', description: 'Buffet specializing in corporate events',
        payment_methods: 'Cash, credit and debit cards', user: user3)
        buffet4 = Buffet.create!(brand_name: 'Diamond Dogs Banquets', corporate_name: 'Diamond Dogs Culinary Services Ltda', cnpj: '79963258000143',
        phone: '11999999996', email: 'diamonddogs@email.com', address: 'Diamond Street, 123', neighborhood: 'Diamond District',
        state: 'Bahia', city: 'Salvador', zip_code: '12345671', description: 'Buffet specializing in themed events and parties',
        payment_methods: 'Cash, credit and debit cards', user: user4)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet1)
        event_price = EventPrice.create!(event: event, wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150)

        visit root_path
        fill_in 'Buscar Buffet', with: 'Buffet do Raiden'
        click_on 'Buscar'

        expect(page).to have_content('Resultados da busca por: Buffet do Raiden')
        expect(page).to have_content('Buffet do Raiden')        
    end

    it 'successfully from brand name and click to see details' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        user2 = User.create!(email: 'raidenz@mgs.com', password: 'solidsnakefanz', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '89032028000114',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        buffet2 = Buffet.create!(brand_name: 'Buffet do Raiden', corporate_name: 'Buffet do Raiden Ltda', cnpj: '90626237000175',
        phone: '11999999998', email: 'raidenbuffet@email.com', address: 'Rua do Raiden, 123', neighborhood: 'Bairro do Raiden',
        state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user2)
        user3 = User.create!(email: 'snake@mgs.com', password: 'metalgearexperience', role: :buffet_owner)
        user4 = User.create!(email: 'ocelot@mgs.com', password: 'tripleagent123', role: :buffet_owner)
        buffet3 = Buffet.create!(brand_name: 'Outer Heaven Catering', corporate_name: 'Outer Heaven Events Ltda', cnpj: '16844554000105',
        phone: '11999999997', email: 'outerheaven@mail.com', address: 'Rua Outer, 123', neighborhood: 'Outer District',
        state: 'Rio de Janeiro', city: 'Rio de Janeiro', zip_code: '12345670', description: 'Buffet specializing in corporate events',
        payment_methods: 'Cash, credit and debit cards', user: user3)
        buffet4 = Buffet.create!(brand_name: 'Diamond Dogs Banquets', corporate_name: 'Diamond Dogs Culinary Services Ltda', cnpj: '79963258000143',
        phone: '11999999996', email: 'diamonddogs@email.com', address: 'Diamond Street, 123', neighborhood: 'Diamond District',
        state: 'Bahia', city: 'Salvador', zip_code: '12345671', description: 'Buffet specializing in themed events and parties',
        payment_methods: 'Cash, credit and debit cards', user: user4)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet1)
        event_price = EventPrice.create!(event: event, wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150)

        visit root_path
        fill_in 'Buscar Buffet', with: 'Buffet do Snake'
        click_on 'Buscar'
        click_on 'Buffet do Snake'

        expect(page).to have_content('Buffet Metal Gear Ltda')
        expect(page).to have_content('89032028000114')
        expect(page).to have_content('11999999999')
        expect(page).to have_content('solidsnakefans@mail.com')
        expect(page).to have_content('Rua do Buffet, 123')
        expect(page).to have_content('Bairro do Buffet')
        expect(page).to have_content('São Paulo')
        expect(page).to have_content('São Paulo')
        expect(page).to have_content('12345678')
        expect(page).to have_content('Buffet especializado em festas de aniversário')
        expect(page).to have_content('Dinheiro, cartão de crédito e débito')
        expect(page).to have_content('Nome do evento: Festa de Aniversário')
        expect(page).to have_content('Descrição do evento: Festa de aniversário com bolo, doces e salgados')
        expect(page).to have_content('Quantidade mínima de pessoas:10')
        expect(page).to have_content('Quantidade máxima de pessoas:100')
        expect(page).to have_content('Duração padrão do evento em minutos:180')
        expect(page).to have_content('Cardápio para o evento: Bolo, doces, salgados, refrigerante, vinho')
        expect(page).to have_content('Serve bebidas alcoólicas: Sim')
        expect(page).to have_content('Possui serviço de decoração: Sim')
        expect(page).to have_content('Possui serviço de estacionamento ou valet: Sim')
        expect(page).to have_content('Aceita outros endereços de Buffet: Sim')
        expect(page).to have_content("Preço do evento mínimo: 2000")
        expect(page).to have_content("Preço adicional por pessoa: 70")
        expect(page).to have_content("Preço adicional por hora: 100")
        expect(page).to have_content("Preço do evento mínimo (final de semana): 2500")
        expect(page).to have_content("Preço adicional por pessoa (final de semana): 80")
        expect(page).to have_content("Preço adicional por hora (final de semana): 150")
    end
    
    it 'successfully from event name' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        user2 = User.create!(email: 'raidenz@mgs.com', password: 'solidsnakefanz', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '89032028000114',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        buffet2 = Buffet.create!(brand_name: 'Buffet do Raiden', corporate_name: 'Buffet do Raiden Ltda', cnpj: '90626237000175',
        phone: '11999999998', email: 'raidenbuffet@email.com', address: 'Rua do Raiden, 123', neighborhood: 'Bairro do Raiden',
        state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user2)
        user3 = User.create!(email: 'snake@mgs.com', password: 'metalgearexperience', role: :buffet_owner)
        user4 = User.create!(email: 'ocelot@mgs.com', password: 'tripleagent123', role: :buffet_owner)
        buffet3 = Buffet.create!(brand_name: 'Outer Heaven Catering', corporate_name: 'Outer Heaven Events Ltda', cnpj: '16844554000105',
        phone: '11999999997', email: 'outerheaven@mail.com', address: 'Rua Outer, 123', neighborhood: 'Outer District',
        state: 'Rio de Janeiro', city: 'Rio de Janeiro', zip_code: '12345670', description: 'Buffet specializing in corporate events',
        payment_methods: 'Cash, credit and debit cards', user: user3)
        buffet4 = Buffet.create!(brand_name: 'Diamond Dogs Banquets', corporate_name: 'Diamond Dogs Culinary Services Ltda', cnpj: '79963258000143',
        phone: '11999999996', email: 'diamonddogs@email.com', address: 'Diamond Street, 123', neighborhood: 'Diamond District',
        state: 'Bahia', city: 'Salvador', zip_code: '12345671', description: 'Buffet specializing in themed events and parties',
        payment_methods: 'Cash, credit and debit cards', user: user4)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet1)
        event2 = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, tortas, palhaço, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: false, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet2)
        event3 = Event.create!(name: 'Festa de Casamento', description: 'Festa de casamento com bolo, tortas, bebidas, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho, drinks', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet2)
        event_price = EventPrice.create!(event: event, wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150)

        visit root_path
        fill_in 'Buscar Buffet', with: 'Festa de Aniversário'
        click_on 'Buscar'

        expect(page).to have_content('Resultados da busca por: Festa de Aniversário')
        expect(page).to have_content('Buffet do Snake')
        expect(page).to have_content('Buffet do Raiden')
        expect(page).not_to have_content('Outer Heaven Catering')
    end

    it 'search for buffets for their cities' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        user2 = User.create!(email: 'raidenz@mgs.com', password: 'solidsnakefanz', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '89032028000114',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        buffet2 = Buffet.create!(brand_name: 'Buffet do Raiden', corporate_name: 'Buffet do Raiden Ltda', cnpj: '90626237000175',
        phone: '11999999998', email: 'raidenbuffet@email.com', address: 'Rua do Raiden, 123', neighborhood: 'Bairro do Raiden',
        state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user2)
        user3 = User.create!(email: 'snake@mgs.com', password: 'metalgearexperience', role: :buffet_owner)
        user4 = User.create!(email: 'ocelot@mgs.com', password: 'tripleagent123', role: :buffet_owner)
        buffet3 = Buffet.create!(brand_name: 'Outer Heaven Catering', corporate_name: 'Outer Heaven Events Ltda', cnpj: '16844554000105',
        phone: '11999999997', email: 'outerheaven@mail.com', address: 'Rua Outer, 123', neighborhood: 'Outer District',
        state: 'Rio de Janeiro', city: 'Rio de Janeiro', zip_code: '12345670', description: 'Buffet specializing in corporate events',
        payment_methods: 'Cash, credit and debit cards', user: user3)
        buffet4 = Buffet.create!(brand_name: 'Diamond Dogs Banquets', corporate_name: 'Diamond Dogs Culinary Services Ltda', cnpj: '79963258000143',
        phone: '11999999996', email: 'diamonddogs@email.com', address: 'Diamond Street, 123', neighborhood: 'Diamond District',
        state: 'Bahia', city: 'Salvador', zip_code: '12345671', description: 'Buffet specializing in themed events and parties',
        payment_methods: 'Cash, credit and debit cards', user: user4)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet1)
        event2 = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, tortas, palhaço, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: false, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet2)
        event3 = Event.create!(name: 'Festa de Casamento', description: 'Festa de casamento com bolo, tortas, bebidas, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho, drinks', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet2)
        event_price = EventPrice.create!(event: event, wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150)

        visit root_path
        fill_in 'Buscar Buffet', with: 'Caxias do Sul'
        click_on 'Buscar'
        
        expect(page).to have_content('Resultados da busca por: Caxias do Sul')
        expect(page).to have_content('Buffet do Raiden')
        expect(page).not_to have_content('Buffet do Snake')
        expect(page).not_to have_content('Outer Heaven Catering')
        expect(page).not_to have_content('Diamond Dogs Banquets')
    end
end