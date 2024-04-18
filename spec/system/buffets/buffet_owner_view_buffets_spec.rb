require 'rails_helper'

describe 'Buffet Owner views his buffet' do
    it 'successfully' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
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
end
            