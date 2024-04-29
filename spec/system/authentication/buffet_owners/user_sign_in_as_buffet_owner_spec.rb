require 'rails_helper'

describe 'User sign in as buffet owner' do
    it 'successfully' do
        user = User.create!(email:'nakedsnake@mgs.com', password: 'bigboss', role: 'buffet_owner')
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        
        visit root_path
        click_on 'Entrar'
        fill_in 'E-mail', with: 'nakedsnake@mgs.com'
        fill_in 'Senha', with: 'bigboss'
        click_on 'Log in'

        expect(page).to have_content('Login efetuado com sucesso.')
        expect(page).to have_content(user.email)
    end

    it 'let the fields blank' do
        visit root_path
        click_on 'Entrar'
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: ''
        click_on 'Log in'

        expect(page).to have_content('E-mail ou senha inválidos.')
    end

    it 'sucessfuly and see exit button' do
        user = User.create!(email:'nakedsnake@mgs.com', password: 'bigboss', role: 'buffet_owner')
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            
        login_as(user, scope: :user)
        visit root_path

        expect(current_path).to eq(root_path)
        expect(page).to have_content(user.email)
        expect(page).to have_button('Sair')
    end
end