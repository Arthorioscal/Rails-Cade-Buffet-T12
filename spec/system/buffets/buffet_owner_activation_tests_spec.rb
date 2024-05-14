require 'rails_helper'

describe 'Buffet owner activation tests' do
    it 'deactivate buffet' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
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
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
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
end