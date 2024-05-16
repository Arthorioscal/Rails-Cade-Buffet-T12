require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe '#validations' do
    it 'validates presence of name' do
      promotion = Promotion.new(start_date: Date.today, end_date: Date.today + 1.week, weekday_discount: 0.5, weekend_discount: 0.7)
      expect(promotion).to_not be_valid
      expect(promotion.errors[:name]).to include("não pode ficar em branco")
    end

    it 'validates presence of start_date' do
      promotion = Promotion.new(name: 'Promotion 1', end_date: Date.today + 1.week, weekday_discount: 0.5, weekend_discount: 0.7)
      expect(promotion).to_not be_valid
      expect(promotion.errors[:start_date]).to include("não pode ficar em branco")
    end

    it 'validates presence of end_date' do
      promotion = Promotion.new(name: 'Promotion 1', start_date: Date.today, weekday_discount: 0.5, weekend_discount: 0.7)
      expect(promotion).to_not be_valid
      expect(promotion.errors[:end_date]).to include("não pode ficar em branco")
    end

    it 'validates presence of weekday_discount' do
      promotion = Promotion.new(name: 'Promotion 1', start_date: Date.today, end_date: Date.today + 1.week, weekend_discount: 0.7)
      expect(promotion).to_not be_valid
      expect(promotion.errors[:weekday_discount]).to include("não pode ficar em branco")
    end

    it 'validates presence of weekend_discount' do
      promotion = Promotion.new(name: 'Promotion 1', start_date: Date.today, end_date: Date.today + 1.week, weekday_discount: 0.5)
      expect(promotion).to_not be_valid
      expect(promotion.errors[:weekend_discount]).to include("não pode ficar em branco")
    end

    it 'validates numericality of weekday_discount' do
      promotion = Promotion.new(name: 'Promotion 1', start_date: Date.today, end_date: Date.today + 1.week, weekday_discount: -0.5, weekend_discount: 0.7)
      expect(promotion).to_not be_valid
      expect(promotion.errors[:weekday_discount]).to include("deve ser maior ou igual a 0")
    end

    it 'validates numericality of weekend_discount' do
      promotion = Promotion.new(name: 'Promotion 1', start_date: Date.today, end_date: Date.today + 1.week, weekday_discount: 0.5, weekend_discount: 1.5)
      expect(promotion).to_not be_valid
      expect(promotion.errors[:weekend_discount]).to include("deve ser menor ou igual a 1")
    end

    it 'validates end_date after start_date' do
      promotion = Promotion.new(name: 'Promotion 1', start_date: Date.today + 1.week, end_date: Date.today, weekday_discount: 0.5, weekend_discount: 0.7)
      expect(promotion).to_not be_valid
      expect(promotion.errors[:end_date]).to include("deve ser maior que a data de início")
    end

    it 'validates start_date and end_date not in the past' do
      promotion = Promotion.new(name: 'Promotion 1', start_date: Date.today - 1.week, end_date: Date.today - 1.day, weekday_discount: 0.5, weekend_discount: 0.7)
      expect(promotion).to_not be_valid
      expect(promotion.errors[:start_date]).to include("não pode ser no passado")
      expect(promotion.errors[:end_date]).to include("não pode ser no passado")
    end
  end
end
