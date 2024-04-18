require 'rails_helper'

describe 'User registers as buffet owner' do 
    it 'sees the registration form' do

        visit root_path
        click_on 'Fazer Cadastro'
        
        expect(page).to have_content('E-mail')
        expect(page).to have_content('Senha')
        expect(page).to have_content('Confirme sua senha')
    end

    it 'successfully from menu' do
        
        visit root_path
        click_on 'Fazer Cadastro'
        within('form') do
            fill_in 'E-mail', with: 'bigboss@mgs.com'
            fill_in 'Senha', with: '123456'
            fill_in 'Confirme sua senha', with: '123456'
            select 'Dono de Buffet', from: 'Tipo de Usuário'
            click_on 'Cadastrar'
        end

        expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
        expect(page).to have_content('bigboss@mgs.com')
    end

    it 'and let the fields blank' do

        visit root_path
        click_on 'Fazer Cadastro'
        within('form') do
            fill_in 'E-mail', with: ''
            fill_in 'Senha', with: ''
            fill_in 'Confirme sua senha', with: ''
            click_on 'Cadastrar'
        end

        expect(page).to have_content('E-mail não pode ficar em branco')
        expect(page).to have_content('A senha não pode ficar em branco')
    end

    it 'and password confirmation does not match' do
            
        visit root_path
        click_on 'Fazer Cadastro'
        within('form') do
            fill_in 'E-mail', with: 'nakedsnake@mgs.com'
            fill_in 'Senha', with: 'bigboss'
            fill_in 'Senha', with: 'nakedsnake'
            click_on 'Cadastrar'
        end

        expect(page).to have_content('Confirmação de senha não é igual a Senha')
    end

    it 'and email already exists' do
            User.create!(email: 'bigboss@mgs', password: '123456', role: :buffet_owner)

        visit root_path
        click_on 'Fazer Cadastro'
        within('form') do
            fill_in 'E-mail', with: 'bigboss@mgs'
            fill_in 'Senha', with: 'nakedsnake'
            fill_in 'Confirme sua senha', with: 'nakedsnake'
            click_on 'Cadastrar'
        end

        expect(page).to have_content('E-mail já cadastrado')
    end
end