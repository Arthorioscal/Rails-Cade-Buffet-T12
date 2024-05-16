require 'rails_helper'

describe 'Guest view registered buffets' do
    it 'successfully' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        buffet2 = Buffet.create!(brand_name: 'Buffet do Raiden', corporate_name: 'Buffet do Raiden Ltda', cnpj: '13877871000130',
        phone: '11999999998', email: 'raidenbuffet@email.com', address: 'Rua do Raiden, 123', neighborhood: 'Bairro do Raiden',
        state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)

        visit root_path

        expect(page).to have_content('Buffet do Snake')
        expect(page).to have_content('Buffet do Raiden')
        expect(page).to have_content('São Paulo - São Paulo')
        expect(page).to have_content('Caxias do Sul - Rio Grande do Sul')
    end

    it 'and view details' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        buffet2 = Buffet.create!(brand_name: 'Buffet do Raiden', corporate_name: 'Buffet do Raiden Ltda', cnpj: '13877871000130',
        phone: '11999999998', email: 'raidenbuffet@email.com', address: 'Rua do Raiden, 123', neighborhood: 'Bairro do Raiden',
        state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)

        visit root_path
        click_on 'Buffet do Snake'

        expect(page).not_to have_content('Buffet Metal Gear Ltda')
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
    end

    it 'and view details with events and prices' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        user2 = User.create!(email: 'raidenz@mgs.com', password: 'solidsnakefanz', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        buffet2 = Buffet.create!(brand_name: 'Buffet do Raiden', corporate_name: 'Buffet do Raiden Ltda', cnpj: '13877871000130',
        phone: '11999999998', email: 'raidenbuffet@email.com', address: 'Rua do Raiden, 123', neighborhood: 'Bairro do Raiden',
        state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet1)
        event_price = EventPrice.create!(event: event, wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150)

        visit root_path
        click_on 'Buffet do Snake'
            
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

    it 'and view buffet with events with photos' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet1, photos: [fixture_file_upload(Rails.root.join('spec/support/images/mgsbirthday.jpg'))])

        visit root_path
        click_on 'Buffet do Snake'
            
        expect(page).to have_css('img[src*="mgsbirthday.jpg"]')
        expect(page).to have_content('45195101000101')
        expect(page).to have_content('11999999999')
        expect(page).to have_content('solidsnakefans@mail.com')
        expect(page).to have_content('Rua do Buffet, 123')
        expect(page).to have_content('Bairro do Buffet')
    end         

    it 'views a buffet with an cover photo attached' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', cover_photo: fixture_file_upload(Rails.root.join('spec/support/images/mgsbirthday.jpg')), user: user)
        Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet1, photos: [fixture_file_upload(Rails.root.join('spec/support/images/mgsbirthday.jpg'))])

        visit root_path
        
        expect(page).to have_css('img[src*="mgsbirthday.jpg"]')
        expect(page).to have_content('Buffet do Snake')
    end
end
