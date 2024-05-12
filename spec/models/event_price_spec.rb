require 'rails_helper'

RSpec.describe EventPrice, type: :model do
    describe 'validations' do
        it 'validates presence of wd_price' do
            event_price = EventPrice.new(wd_price: nil)



            expect(event_price).not_to be_valid
            expect(event_price.errors[:wd_price]).to include("Preço (Durante a semana) não pode ficar em branco")
        end

        it 'validates presence of wd_add_person_price' do
            event_price = EventPrice.new(wd_add_person_price: nil)



            expect(event_price).not_to be_valid
            expect(event_price.errors[:wd_add_person_price]).to include("Preço adicional por pessoa (Durante a semana) não pode ficar em branco")
        end

        it 'validates presence of wd_extra_hour_price' do
            event_price = EventPrice.new(wd_extra_hour_price: nil)



            expect(event_price).not_to be_valid
            expect(event_price.errors[:wd_extra_hour_price]).to include("Preço extra por hora (Durante a semana) não pode ficar em branco")
        end

        it 'validates presence of we_price' do
            event_price = EventPrice.new(we_price: nil)



            expect(event_price).not_to be_valid
            expect(event_price.errors[:we_price]).to include("Preço (Fim de semana) não pode ficar em branco")
        end

        it 'validates presence of we_add_person_price' do
            event_price = EventPrice.new(we_add_person_price: nil)



            expect(event_price).not_to be_valid
            expect(event_price.errors[:we_add_person_price]).to include("Preço adicional por pessoa (Fim de semana) não pode ficar em branco")
        end

        it 'validates presence of we_extra_hour_price' do
            event_price = EventPrice.new(we_extra_hour_price: nil)



            expect(event_price).not_to be_valid
            expect(event_price.errors[:we_extra_hour_price]).to include("Preço extra por hora (Fim de semana) não pode ficar em branco")
        end
    end
end
