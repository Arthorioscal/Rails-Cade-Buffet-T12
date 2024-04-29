require 'rails_helper'

describe 'Buffet Owner views his buffet' do
    it 'successfully' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        
        expect(page).to have_content('Meu Buffet')
        expect(page).to have_content('Buffet do Snake')
        expect(page).to have_content('Buffet do Snake Ltda')
    end

    it 'and only see his own buffet' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        user2 = User.create!(email: 'bigboss@mgs.com', password: 'solidsnakedad', role: :buffet_owner)
        buffet2 = Buffet.create!(brand_name: 'Buffet do Big Boss', corporate_name: 'Buffet do Big Boss Ltda', cnpj: '13877871000130',
        phone: '11999999998', email: 'bigboss@contact.com', address: 'Rua do Big Boss, 123', neighborhood: 'Bairro do Big Boss',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user2)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        
        expect(page).to have_content('Meu Buffet')
        expect(page).to have_content('Buffet do Snake')
        expect(page).to have_content('Buffet do Snake Ltda')
        expect(page).not_to have_content('Buffet do Big Boss')
        expect(page).not_to have_content('Buffet do Big Boss Ltda')
    end
end
            