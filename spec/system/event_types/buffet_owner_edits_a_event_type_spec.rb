require 'rails_helper'

describe 'Buffet owner edits a event type' do
    it 'successfully' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Editar Evento'
        fill_in 'Nome', with: 'Festa de Aniversário Infantil'
        fill_in 'Descrição', with: 'Festa de aniversário infantil com bolo, doces e salgados'
        fill_in 'Quantidade mínima de pessoas', with: 15
        fill_in 'Quantidade máxima de pessoas', with: 150
        fill_in 'Duração', with: 240
        fill_in 'Cardápio', with: 'Bolo, doces, salgados, refrigerante, suco, água'
        uncheck 'Serve bebidas alcoólicas'
        check 'Possui serviço de decoração'
        check 'Possui serviço de estacionamento ou valet'
        check 'Aceita outros endereços de Buffet'
        click_on 'Cadastrar'

        expect(page).to have_content('Festa de Aniversário Infantil')
        expect(page).to have_content('Festa de aniversário infantil com bolo, doces e salgados')
        expect(page).to have_content('15')
        expect(page).to have_content('150')
        expect(page).to have_content('240')
        expect(page).to have_content('Bolo, doces, salgados, refrigerante, suco, água')
        expect(page).to have_content('Não')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Sim')
        expect(page).to have_content('Tipo de evento atualizado com sucesso')
    end

    it 'and must fill in all fields' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
        max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
        at_buffet_location: true, buffet: buffet)

        login_as(user, scope: :user)
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Editar Evento'
        fill_in 'Nome', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Quantidade mínima de pessoas', with: ''
        fill_in 'Quantidade máxima de pessoas', with: ''
        fill_in 'Duração', with: ''
        fill_in 'Cardápio', with: ''
        click_on 'Cadastrar'

        expect(page).to have_content('Não foi possível atualizar o tipo de evento, tente novamente')
        expect(page).to have_content('Não foi possível atualizar o tipo de evento, tente novamente')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Quantidade mínima de pessoas não pode ficar em branco')
        expect(page).to have_content('Quantidade máxima de pessoas não pode ficar em branco')
        expect(page).to have_content('Duração padrão do evento em minutos não pode ficar em branco')
        expect(page).to have_content('Cardápio para o evento não pode ficar em branco')
    end
end