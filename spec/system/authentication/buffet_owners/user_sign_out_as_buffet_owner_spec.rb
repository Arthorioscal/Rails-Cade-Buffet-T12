require 'rails_helper'

describe 'User log out as buffet owner' do
    it 'successfully' do
        user = User.create!(email:'nakedsnake@mgs.com', password: 'bigboss', role: 'buffet_owner')
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)

        login_as(user, scope: :user)
        visit root_path
        click_button 'Sair'

        expect(page).to have_content('Logout efetuado com sucesso.')
    end
end