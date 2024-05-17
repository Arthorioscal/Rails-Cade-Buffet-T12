require 'rails_helper'

describe 'Buffet owner register cancellation rules' do
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

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Cadastrar Regras de Cancelamento'
        fill_in 'Dias antes do evento para cancelamento parcial', with: '10'
        fill_in 'Multa para cancelamento parcial', with: '0.1'
        fill_in 'Dias antes do evento para cancelamento total', with: '1'
        fill_in 'Multa para cancelamento total', with: '1.0'
        click_on 'Cadastrar'
        
        expect(page).to have_content('Regras de cancelamento atualizadas com sucesso.')
        expect(page).to have_content('Dias para Cancelamento Parcial: 10 dias(s)')
        expect(page).to have_content('Multa para Cancelamento Parcial: 10.0%')
        expect(page).to have_content('Dias para Cancelamento Total: 1 dias(s)')
        expect(page).to have_content('Multa para Cancelamento Total: 100.0%')
    end

    it 'and must fill all fields' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)
        event_price = EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Cadastrar Regras de Cancelamento'
        fill_in 'Dias antes do evento para cancelamento parcial', with: ''
        fill_in 'Multa para cancelamento parcial', with: ''
        fill_in 'Dias antes do evento para cancelamento total', with: ''
        fill_in 'Multa para cancelamento total', with: ''
        click_on 'Cadastrar'

        expect(page).to have_content('Cadastre Aqui as regras referente ao cancelamento de pedidos:')
    end
end
        