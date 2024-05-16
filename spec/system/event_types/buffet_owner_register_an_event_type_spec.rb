require 'rails_helper'

describe 'Buffet Owner register event types' do
    it 'successfully after he sign in' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Cadastrar Tipo de Evento'
            fill_in 'Nome', with: 'Festa de Aniversário'
            fill_in 'Descrição', with: 'Festa de aniversário com bolo, doces e salgados'
            fill_in 'Quantidade mínima de pessoas', with: 10
            fill_in 'Quantidade máxima de pessoas', with: 100
            fill_in 'Duração padrão do evento em minutos', with: 180
            fill_in 'Cardápio para o evento', with: 'Bolo, doces, salgados, refrigerante, vinho'
            check 'Serve bebidas alcoólicas'
            check 'Possui serviço de decoração'
            check 'Possui serviço de estacionamento ou valet'
            check 'Aceita outros endereços de Buffet'
            click_on 'Cadastrar'

        expect(page).to have_content('Tipo de evento cadastrado com sucesso')
        expect(page).to have_content('Festa de Aniversário')
        expect(page).to have_content('Festa de aniversário com bolo, doces e salgados')
        expect(page).to have_content('10')
        expect(page).to have_content('100')
        expect(page).to have_content('180')
        expect(page).to have_content('Bolo, doces, salgados, refrigerante, vinho')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
    end

    it 'and must fill in all fields' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Cadastrar Tipo de Evento'
        fill_in 'Nome', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Quantidade mínima de pessoas', with: ''
        fill_in 'Quantidade máxima de pessoas', with: ''
        fill_in 'Duração padrão do evento em minutos', with: ''
        fill_in 'Cardápio para o evento', with: ''
        uncheck 'Serve bebidas alcoólicas'
        uncheck 'Possui serviço de decoração'
        uncheck 'Possui serviço de estacionamento ou valet'
        uncheck 'Aceita outros endereços de Buffet'
        click_on 'Cadastrar'

        expect(page).to have_content('Não foi possível cadastrar o tipo de evento, tente novamente')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Quantidade mínima de pessoas não pode ficar em branco')
        expect(page).to have_content('Quantidade máxima de pessoas não pode ficar em branco')
        expect(page).to have_content('Duração padrão do evento em minutos não pode ficar em branco')
        expect(page).to have_content('Cardápio para o evento não pode ficar em branco')
    end

    it 'and he uploads photos for the event type' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Cadastrar Tipo de Evento'
        fill_in 'Nome', with: 'Festa de Aniversário'
        fill_in 'Descrição', with: 'Festa de aniversário com bolo, doces e salgados'
        fill_in 'Quantidade mínima de pessoas', with: 10
        fill_in 'Quantidade máxima de pessoas', with: 100
        fill_in 'Duração padrão do evento em minutos', with: 180
        fill_in 'Cardápio para o evento', with: 'Bolo, doces, salgados, refrigerante, vinho'
        check 'Serve bebidas alcoólicas'
        check 'Possui serviço de decoração'
        check 'Possui serviço de estacionamento ou valet'
        check 'Aceita outros endereços de Buffet'
        attach_file 'Fotos do Evento', Rails.root.join('spec', 'support', 'images', 'mgsbirthday.jpg')
        click_on 'Cadastrar'

        expect(page).to have_content('Tipo de evento cadastrado com sucesso')
        expect(page).to have_content('Fotos do Evento')
        expect(page).to have_css('img[src*="mgsbirthday.jpg"]')
    end

    it 'and he can register more than one event type' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 50,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Cadastrar outro Tipo de Evento'
        fill_in 'Nome', with: 'Festa de Aniversário'
        fill_in 'Descrição', with: 'Festa de aniversário com bolo, doces e salgados'
        fill_in 'Quantidade mínima de pessoas', with: 10
        fill_in 'Quantidade máxima de pessoas', with: 100
        fill_in 'Duração padrão do evento em minutos', with: 180
        fill_in 'Cardápio para o evento', with: 'Bolo, doces, salgados, refrigerante, vinho'
        check 'Serve bebidas alcoólicas'
        check 'Possui serviço de decoração'
        check 'Possui serviço de estacionamento ou valet'
        check 'Aceita outros endereços de Buffet'
        click_on 'Cadastrar'

        expect(page).to have_content('Tipo de evento cadastrado com sucesso')
        expect(page).to have_content('Festa de Aniversário')
        expect(page).to have_content('Festa de aniversário com bolo, doces e salgados')
        expect(page).to have_content('10')
        expect(page).to have_content('100')
        expect(page).to have_content('180')
        expect(page).to have_content('Bolo, doces, salgados, refrigerante, vinho')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
    end
end 
