require 'rails_helper'

RSpec.describe Buffet, type: :model do
    describe '#valid?' do
        context 'presence' do
            it 'false when brand_name is blank' do
                user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: '', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                expect(buffet.valid?).to be_falsey
            end
            
            it 'false when corporate_name is blank' do
                user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: 'Buffet do Snake', corporate_name: '', cnpj: '12345678901234',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                expect(buffet.valid?).to be_falsey
            end
        end
    end
end
