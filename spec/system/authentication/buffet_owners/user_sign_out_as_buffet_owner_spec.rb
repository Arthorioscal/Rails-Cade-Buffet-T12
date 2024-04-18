require 'rails_helper'

describe 'User log out as buffet owner' do
    it 'successfully' do
        user = User.create!(email:'nakedsnake@mgs.com', password: 'bigboss', role: 'buffet_owner')

        login_as(user, scope: :user)
        visit root_path
        click_button 'Sair'

        expect(page).to have_content('Logout efetuado com sucesso.')
    end
end