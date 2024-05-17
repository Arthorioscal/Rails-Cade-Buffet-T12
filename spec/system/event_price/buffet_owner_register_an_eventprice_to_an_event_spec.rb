require 'rails_helper'

describe 'Buffet owner register event prices' do
    it 'successfully after he sign in' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Cadastrar Preço deste Evento'
        fill_in 'Preço (Durante a semana)', with: 2000
        fill_in 'Preço adicional por pessoa (Durante a semana)', with: 70
        fill_in 'Preço extra por hora (Durante a semana)', with: 100
        fill_in 'Preço (Fim de semana)', with: 2500
        fill_in 'Preço adicional por pessoa (Fim de semana)', with: 80
        fill_in 'Preço extra por hora (Fim de semana)', with: 150
        click_on 'Cadastrar'

        expect(page).to have_content('Preço do evento foi cadastrado com sucesso.')
    end

    it 'and must fill in all fields' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Cadastrar Preço deste Evento'
        fill_in 'Preço (Durante a semana)', with: ''
        fill_in 'Preço adicional por pessoa (Durante a semana)', with: ''
        fill_in 'Preço extra por hora (Durante a semana)', with: ''
        fill_in 'Preço (Fim de semana)', with: ''
        fill_in 'Preço adicional por pessoa (Fim de semana)', with: ''
        fill_in 'Preço extra por hora (Fim de semana)', with: ''
        click_on 'Cadastrar'

        expect(page).to have_content('Não foi possível cadastrar o preço do evento.')
        expect(page).to have_content("Preço (Durante a semana) não pode ficar em branco")
        expect(page).to have_content("Preço adicional por pessoa (Durante a semana) não pode ficar em branco")
        expect(page).to have_content("Preço extra por hora (Durante a semana) não pode ficar em branco")
        expect(page).to have_content("Preço (Fim de semana) não pode ficar em branco")
        expect(page).to have_content("Preço adicional por pessoa (Fim de semana) não pode ficar em branco")
        expect(page).to have_content("Preço extra por hora (Fim de semana) não pode ficar em branco")
    end 
end