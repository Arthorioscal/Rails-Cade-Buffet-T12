require 'rails_helper'

RSpec.describe User, type: :model do
    context 'validation' do
        it 'attributes cannot be blank' do
            user = User.new

            user.valid?

            expect(user.errors[:email]).to include('E-mail não pode ficar em branco')
            expect(user.errors[:password]).to include('A senha não pode ficar em branco')
        end

        it 'email must be unique' do
            User.create!(email: 'raiden@mgs.com', password: 'solidsnakefan', role: :buffet_owner)
            user2 = User.new(email: 'raiden@mgs.com', password: 'solidsnake', role: 2)

            user2.valid?

            expect(user2).to_not be_valid
        end

        it 'role must be in roles list' do
            user = User.new(email: 'bigboss@email.com', password: 'nakedsnake', role: 5)

            user.valid?

            expect(user.errors[:role]).to include('5 não é um tipo de usuário válido')
        end

        it 'cpf must be unique' do
            User.create!(email: 'solidsnake@gmail.com', password: 'solidsnake', name: 'Solid Snake', cpf: '11543210023', role: :client)
            user = User.new(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '11543210023', role: :client)

            user.valid?

            expect(user.errors[:cpf]).to include('já está em uso')
        end

        it 'cpf must be valid' do
            user = User.new(email: 'bigboss@gmail.com', password: 'bigboss', name: 'Big Boss', cpf: '123456789', role: :client)

            user.valid?

            expect(user.errors[:cpf]).to include('Inválido, tente novamente.')
        end
    end
end
