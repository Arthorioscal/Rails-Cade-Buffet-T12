require 'rails_helper'

RSpec.describe Event, type: :model do
    context 'validations' do

        it 'name cannot be blank' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.new(name: '', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)

            event.valid?

            expect(event.errors.full_messages).to include( 'Nome não pode ficar em branco' )
        end

        it 'description cannot be blank' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.new(name: 'Festa de Aniversário', description: '', min_people: 10,
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)

            event.valid?

            expect(event.errors.full_messages).to include( 'Descrição não pode ficar em branco' )
        end

        it 'min_people cannot be blank' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.new(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: '',
            max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)

            event.valid?

            expect(event.errors.full_messages).to include( 'Quantidade mínima de pessoas Quantidade mínima de pessoas não pode ficar em branco' )
        end

        it 'max_people cannot be blank' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.new(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
            max_people: '', duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)

            event.valid?

            expect(event.errors.full_messages).to include( 'Quantidade máxima de pessoas Quantidade máxima de pessoas não pode ficar em branco' )
        end

        it 'duration cannot be blank' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.new(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
            max_people: 100, duration: nil, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)

            event.valid?

            expect(event.errors.full_messages).to include( 'Duração padrão do evento em minutos Duração padrão do evento em minutos não pode ficar em branco' )
        end

        it 'menu cannot be blank' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.new(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
            max_people: 100, duration: 180, menu: '', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)

            event.valid?

            expect(event.errors.full_messages).to include( 'Cardápio para o evento Cardápio para o evento não pode ficar em branco' )
        end

        it 'min_people cannot be zero' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.new(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 0,
            max_people: 50, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)

            event.valid?

            expect(event.errors.full_messages).to include( 'Quantidade mínima de pessoas Quantidade mínima de pessoas deve ser maior que 0' )
        end

        it 'max_people cannot be zero' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.new(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
            max_people: 0, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)

            event.valid?

            expect(event.errors.full_messages).to include( 'Quantidade máxima de pessoas Quantidade máxima de pessoas deve ser maior que 0' )
        end

        it 'duration cannot be zero' do
            user = User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            buffet = Buffet.create!(brand_name: 'Buffet do Snake', corporate_name: 'Buffet do Snake Ltda', cnpj: '45195101000101',
            phone: '11999999999', email: 'solidsnakefans@mail.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
            state: 'São Paulo', city: 'São Paulo', zip_code: '12345678', description: 'Buffet especializado em festas de aniversário',
            payment_methods: 'Dinheiro, cartão de crédito e débito', user: user)
            event = Event.new(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 10,
            max_people: 30, duration: 0, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
            at_buffet_location: true, buffet: buffet)

            event.valid?

            expect(event.errors.full_messages).to include( 'Duração padrão do evento em minutos Duração padrão do evento em minutos deve ser maior que 0' )
        end
    end
end
