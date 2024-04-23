require 'rails_helper'

describe 'Buffet Owner register buffets' do
    it 'successfully from account creation' do
        
        visit root_path
        click_on 'Fazer Cadastro'
            fill_in 'E-mail', with: 'bigboss@mgs.com'
            fill_in 'Senha', with: '123456'
            fill_in 'Confirme sua senha', with: '123456'
            click_on 'Cadastrar'
        fill_in 'Nome Fantasia', with: 'Buffet do Snake'
        fill_in 'Razão Social', with: 'Buffet do Snake Ltda'
        fill_in 'CNPJ', with: '12345678901234'
        fill_in 'Telefone para contato', with: '11999999999'
        fill_in 'Email para contato', with: 'metalgearbuffets@buffet.com'
        fill_in 'Endereço', with: 'Rua do Buffet, 123'
        fill_in 'Bairro', with: 'Bairro do Buffet'
        fill_in 'Estado', with: 'São Paulo'
        fill_in 'Cidade', with: 'São Paulo'
        fill_in 'CEP', with: '12345678'
        fill_in 'Descrição', with: 'Buffet especializado em festas de aniversário'
        fill_in 'Formas de pagamento', with: 'Dinheiro, cartão de crédito e débito'
        click_on 'Cadastrar'

        expect(page).to have_content('Buffet cadastrado com sucesso.')
    end

    it 'and must fill in all fields' do

        visit root_path
        click_on 'Fazer Cadastro'
            fill_in 'E-mail', with: 'nakedsnake@mgs.com'
            fill_in 'Senha', with: '123456'
            fill_in 'Confirme sua senha', with: '123456'
            click_on 'Cadastrar'
        fill_in 'Nome Fantasia', with: ''
        fill_in 'Razão Social', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Telefone para contato', with: ''
        click_on 'Cadastrar'

        expect(page).to have_content('Não foi possível cadastrar o buffet, tente novamente')
    end
end

