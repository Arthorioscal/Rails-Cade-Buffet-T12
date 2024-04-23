require 'rails_helper'

describe 'User signs up as a client' do
    it 'successfully with valid cpf' do
        
        visit root_path
        click_on 'Fazer Cadastro'
        select 'Cliente', from: 'Tipo de Usuário'
        fill_in 'E-mail', with: 'nakedsnake@mgs.com'
        fill_in 'Senha', with: 'bigboss'
        fill_in 'Confirme sua senha', with: 'bigboss'
        fill_in 'Nome', with: 'Naked Snake'
        fill_in 'CPF', with: '123.456.789-00'
        click_on 'Cadastrar'

        expect(page).to have_content('Cadastro efetuado com sucesso.')
    end
end