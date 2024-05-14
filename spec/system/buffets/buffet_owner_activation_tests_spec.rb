require 'rails_helper'

describe 'Buffet owner activation tests' do
    it 'deactivate buffet' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Ativar/Desativar Buffet'

        expect(page).to have_content('Status do buffet atualizado com sucesso.')
        expect(page).to have_content('Status do Buffet: Inativo')
    end

    it 'activate buffet' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user, active: false)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Ativar/Desativar Buffet'

        expect(page).to have_content('Status do buffet atualizado com sucesso.')
        expect(page).to have_content('Status do Buffet: Ativo')
    end

    it 'deactivate one event of the buffet' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '89032028000114',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'Caxias do Sul', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet1)
        EventPrice.create!(event: event, wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Ativar/Desativar Evento'

        expect(page).to have_content('Status do tipo de evento atualizado com sucesso.')
        expect(page).to have_content('Status do Evento: Inativo')
    end

    it 'activate one event of the buffet' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '89032028000114',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'Caxias do Sul', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet1, active: false)
        EventPrice.create!(event: event, wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Ativar/Desativar Evento'

        expect(page).to have_content('Status do tipo de evento atualizado com sucesso.')
        expect(page).to have_content('Status do Evento: Ativo')
    end
end