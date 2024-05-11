require 'rails_helper'

describe 'Buffet Owner register buffets' do
    it 'successfully from account creation' do
        
        visit root_path
        click_on 'Fazer Cadastro'
        click_on 'Registrar como um Dono de Buffet'
        fill_in 'E-mail', with: 'bigboss@mgs.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Cadastrar'
        fill_in 'Nome Fantasia', with: 'Buffet do Snake'
        fill_in 'Razão Social', with: 'Buffet do Snake Ltda'
        fill_in 'CNPJ', with: '45195101000101'
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
        click_on 'Registrar como um Dono de Buffet'
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
    it 'visit root path after register before registering a buffet and registration prompts again' do

        visit root_path
        click_on 'Fazer Cadastro'
        click_on 'Registrar como um Dono de Buffet'
        fill_in 'E-mail', with: 'bigboss@gmail.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Cadastrar'
        visit root_path

        expect(page).to have_content('Você precisa cadastrar um buffet para continuar')
        expect(page).to have_content('Nome Fantasia')
        expect(page).to have_content('Razão Social')
        expect(page).to have_content('CNPJ')
        expect(page).to have_content('Telefone para contato')
        expect(page).to have_content('Email para contato')
        expect(page).to have_content('Endereço')
        expect(page).to have_content('Bairro')
        expect(page).to have_content('Estado')
        expect(page).to have_content('Cidade')
        expect(page).to have_content('CEP')
        expect(page).to have_content('Descrição')
        expect(page).to have_content('Formas de pagamento')
    end

    it 'signs out in the registration page' do

        visit root_path
        click_on 'Fazer Cadastro'
        click_on 'Registrar como um Dono de Buffet'
        fill_in 'E-mail', with: 'bigboss@mgs.com'
        fill_in 'Senha', with: '123456'
        fill_in 'Confirme sua senha', with: '123456'
        click_on 'Cadastrar'
        click_on 'Sair'

        expect(page).to have_content('Fazer Cadastro')
        expect(page).to have_content('Entrar')
    end
end

