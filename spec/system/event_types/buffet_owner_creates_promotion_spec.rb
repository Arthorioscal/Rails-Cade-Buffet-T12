require 'rails_helper'

describe 'Buffet owner creates promotion' do
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
        
        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Criar Promoção'
        fill_in 'Nome', with: 'Promoção de Aniversário'
        fill_in 'Data de Início', with: 2.days.from_now
        fill_in 'Data de Término', with: 10.days.from_now
        fill_in 'Desconto para dias de semana', with: 0.1
        fill_in 'Desconto para finais de semana', with: 0.05
        click_on 'Criar Promoção'

        expect(page).to have_content('Promoção de Aniversário')
        expect(page).to have_content("Início da Promoção: #{2.days.from_now.strftime('%d/%m/%Y')} / Fim da Promoção: #{10.days.from_now.strftime('%d/%m/%Y')}")
        expect(page).to have_content('Desconto para Eventos de Segunda a Sexta: 10.0%')
        expect(page).to have_content('Desconto para Eventos de Fim de Semana: 5.0%')
    end

    it 'and deletes active promotion' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        event = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 50,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)
        EventPrice.create!(wd_price: 3000, wd_add_person_price: 100, wd_extra_hour_price: 400, we_price: 4500, we_add_person_price: 150, we_extra_hour_price: 800, event: event)
        Promotion.create!(name: 'DEU A LOCA NO DONO', start_date: 1.day.from_now, end_date: 10.days.from_now, weekday_discount: 0.1, weekend_discount: 0.05, event: event)

        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Deletar Promoção'

        expect(page).to have_content('Promoção excluída com sucesso')
        expect(page).to have_content('Você ainda não tem nenhuma promoção ativa.')
    end
end