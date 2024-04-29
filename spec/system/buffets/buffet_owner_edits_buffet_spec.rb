require 'rails_helper'

describe 'Buffet Owner edits his buffet' do
    it 'successfully' do
        user = User.create(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Editar'
        fill_in 'Nome Fantasia', with: 'Buffet do Raiden'
        fill_in 'Razão Social', with: 'Buffet do Raiden Ltda'
        fill_in 'CNPJ', with: '12345678901235'
        fill_in 'Telefone para contato', with: '11999999998'
        click_on 'Cadastrar'

        expect(page).to have_content('Buffet atualizado com sucesso.')
        expect(page).to have_content('Buffet do Raiden')
        expect(page).to have_content('Buffet do Raiden Ltda')
    end

    it 'and must fill in all fields' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
        phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
        state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
        payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Meu Buffet'
        click_on 'Editar'
        fill_in 'Nome Fantasia', with: ''
        fill_in 'Razão Social', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Telefone para contato', with: ''
        click_on 'Cadastrar'

        expect(page).to have_content('Não foi possível atualizar o buffet, tente novamente')
    end

    it 'and its not his buffet' do
        user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
        user2 = User.create!(email: 'revolverocelot@tripleagent.com', password: 'revolverocelot', role: :buffet_owner)
        buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
        buffet2 = Buffet.create!(brand_name: 'Buffet do Ocelot', corporate_name: 'Buffet do Ocelot Ltda', cnpj: '12345678901235',
            phone: '11999999998', email: 'ocelotltda@contact.com', address: 'Rua do Ocelot, 123', neighborhood: 'Bairro do Ocelot',
            state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user2)

        login_as user2, scope: :user
        patch(buffet_path(buffet1), params: { buffet: { brand_name: 'getrolledltda'} })

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Você não tem permissão para acessar essa página')
    end
end