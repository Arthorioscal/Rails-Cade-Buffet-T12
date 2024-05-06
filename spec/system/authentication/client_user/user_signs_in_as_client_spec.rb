require 'rails_helper'

describe 'User signs in as a client' do
    it 'successfully with valid cpf' do
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)

        visit root_path
        click_on 'Entrar'
        fill_in 'E-mail', with: 'bigboss@gmail.com'
        fill_in 'Senha', with: 'bigboss'
        click_on 'Log in'

        expect(page).to have_content('Login efetuado com sucesso')
    end

    it 'and must fill in all fields' do
        client = User.create!(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)

        visit root_path
        click_on 'Entrar'
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: ''
        click_on 'Log in'

        expect(page).to have_content('E-mail ou senha inválidos.')
    end
end