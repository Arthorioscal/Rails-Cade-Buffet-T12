require 'rails_helper'

describe 'User signs up as a client' do
    it 'successfully with valid cpf' do
        
        visit root_path
        click_on 'Fazer Cadastro'
        click_on 'Registrar como um Cliente'
        fill_in 'E-mail', with: 'nakedsnake@mgs.com'
        fill_in 'Senha', with: 'bigboss'
        fill_in 'Confirme sua senha', with: 'bigboss'
        fill_in 'Nome', with: 'Naked Snake'
        fill_in 'CPF', with: '20201881047'
        click_on 'Cadastrar'

        expect(page).to have_content('Você realizou seu registro com sucesso.')
    end

    it 'and CPF must be unique' do
        User.create!(email: 'solidsnake@mgs.com', password: 'hateyoubigboss', name: 'Solid Snake', cpf: '20201881047', role: 'client')

        visit root_path
        click_on 'Fazer Cadastro'
        click_on 'Registrar como um Cliente'
        fill_in 'E-mail', with: 'nakedsnake@mgs.com'
        fill_in 'Senha', with: 'bigboss'
        fill_in 'Confirme sua senha', with: 'bigboss'
        fill_in 'Nome', with: 'Naked Snake'
        fill_in 'CPF', with: '20201881047'
        click_on 'Cadastrar'

        expect(page).to have_content('CPF já está em uso')
    end

    it 'and CPF must be valid' do

        visit root_path
        click_on 'Fazer Cadastro'
        click_on 'Registrar como um Cliente'
        fill_in 'E-mail', with: 'nakedsnake@mgs.com'
        fill_in 'Senha', with: 'bigboss'
        fill_in 'Confirme sua senha', with: 'bigboss'
        fill_in 'Nome', with: 'Naked Snake'
        fill_in 'CPF', with: '12345678910'
        click_on 'Cadastrar'

        expect(page).to have_content('CPF Inválido, tente novamente.')
    end

    it 'and must fill in all fields' do
            
        visit root_path
        click_on 'Fazer Cadastro'
        click_on 'Registrar como um Cliente'
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: ''
        fill_in 'Confirme sua senha', with: ''
        fill_in 'Nome', with: ''
        fill_in 'CPF', with: ''
        click_on 'Cadastrar'

        expect(page).to have_content('Não foi possível salvar usuário')
        expect(page).to have_content('E-mail não pode ficar em branco')
        expect(page).to have_content('A senha não pode ficar em branco')
        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('CPF não pode ficar em branco')
    end
    
    it 'guests will register from the login page' do

        visit root_path
        click_on 'Fazer Cadastro'
        click_on 'Registrar como um Cliente'
        fill_in 'E-mail', with: 'nakedsnake@mgs.com'
        fill_in 'Senha', with: 'bigboss'
        fill_in 'Confirme sua senha', with: 'bigboss'
        fill_in 'Nome', with: 'Naked Snake'
        fill_in 'CPF', with: '20201881047'
        click_on 'Cadastrar'

        expect(page).to have_content('Você realizou seu registro com sucesso.')
    end
end