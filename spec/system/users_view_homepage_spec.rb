require 'rails_helper'

describe 'Users view homepage', type: :system do
    it 'shows the homepage without any authentication' do


        visit root_path

        expect(page).to have_content('Cade Buffet')
    end
end