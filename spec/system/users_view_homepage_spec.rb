require 'rails_helper'

describe 'Users view homepage', type: :system do
    it 'shows the homepage without any authentication' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        user2 = User.create!(email: 'raidenz@mgs.com', password: 'solidsnakefanz', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        buffet2 = Buffet.create!(brand_name: 'Buffet do Raiden', corporate_name: 'Buffet do Raiden Ltda', cnpj: '13877871000130',
        phone: '11999999998', email: 'raidenbuffet@email.com', address: 'Rua do Raiden, 123', neighborhood: 'Bairro do Raiden',
        state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user2)
        user3 = User.create!(email: 'snake@mgs.com', password: 'metalgearexperience', role: :buffet_owner)
        user4 = User.create!(email: 'ocelot@mgs.com', password: 'tripleagent123', role: :buffet_owner)
        buffet3 = Buffet.create!(brand_name: 'Outer Heaven Catering', corporate_name: 'Outer Heaven Events Ltda', cnpj: '12345678901236',
        phone: '11999999997', email: 'outerheaven@mail.com', address: 'Rua Outer, 123', neighborhood: 'Outer District',
        state: 'Rio de Janeiro', city: 'Rio de Janeiro', zip_code: '12345670', description: 'Buffet specializing in corporate events',
        payment_methods: 'Cash, credit and debit cards', user: user3)
        buffet4 = Buffet.create!(brand_name: 'Diamond Dogs Banquets', corporate_name: 'Diamond Dogs Culinary Services Ltda', cnpj: '12345678901237',
        phone: '11999999996', email: 'diamonddogs@email.com', address: 'Diamond Street, 123', neighborhood: 'Diamond District',
        state: 'Bahia', city: 'Salvador', zip_code: '12345671', description: 'Buffet specializing in themed events and parties',
        payment_methods: 'Cash, credit and debit cards', user: user4)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet1)
        event_price = EventPrice.create!(event: event, wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150)



        visit root_path

        expect(page).to have_content('Cade Buffet')
    end
end