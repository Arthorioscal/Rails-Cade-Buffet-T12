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

            it 'false when cnpj is blank' do
                user = User.create(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                expect(buffet.valid?).to be_falsey
            end

            it 'false when phone is blank' do
                user = User.create(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
                phone: '', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                expect(buffet.valid?).to be_falsey
            end

            it 'false when email is blank' do
                user = User.create(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
                phone: '11999999999', email: '', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                expect(buffet.valid?).to be_falsey
            end

            it 'false when address is blank' do
                user = User.create(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: '', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                expect(buffet.valid?).to be_falsey
            end

            it 'false when neighborhood is blank' do
                user = User.create(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: '',
                state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                expect(buffet.valid?).to be_falsey
            end

            it 'false when state is blank' do
                user = User.create(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: '', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                expect(buffet.valid?).to be_falsey
            end

            it 'false when city is blank' do
                user = User.create(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: '', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                expect(buffet.valid?).to be_falsey
            end

            it 'false when zip_code is blank' do
                user = User.create(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: 'São Paulo', zip_code: '', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                expect(buffet.valid?).to be_falsey
            end

            it 'false when description is blank' do
                user = User.create(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: '',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                expect(buffet.valid?).to be_falsey
            end

            it 'false when payment_methods is blank' do
                user = User.create(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                buffet = Buffet.new(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '12345678901234',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: '', user: user)
                expect(buffet.valid?).to be_falsey
            end
        end

        context 'uniqueness' do
            it 'false when cnpj is not unique' do
                user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                user2 = User.create!(email: 'raidenz@mgs.com', password: 'solidsnakefanz', role: :buffet_owner)
                buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '12345678901234',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                buffet2 = Buffet.new(brand_name: 'Buffet do Raiden', corporate_name: 'Buffet do Raiden Ltda', cnpj: '12345678901234',
                phone: '11999999998', email: 'raidenbuffet@email.com', address: 'Rua do Raiden, 123', neighborhood: 'Bairro do Raiden',
                state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user2)
                expect(buffet2.valid?).to be_falsey
            end

            it 'false when email is not unique' do
                user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
                user2 = User.create!(email: 'raidenz@mgs.com', password: 'solidsnakefanz', role: :buffet_owner)
                buffet1 = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet Metal Gear Ltda', cnpj: '12345678901234',
                phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
                state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
                buffet2 = Buffet.new(brand_name: 'Buffet do Raiden', corporate_name: 'Buffet do Raiden Ltda', cnpj: '12345678901234',
                phone: '11999999998', email: 'solidsnakefans@mail.com', address: 'Rua do Raiden, 123', neighborhood: 'Bairro do Raiden',
                state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '12345679', description: 'Buffet especializado em festas de casamento',
                payment_methods: 'Dinheiro, cartão de crédito e débito', user: user2)
                expect(buffet2.valid?).to be_falsey
            end
        end
    end
end
