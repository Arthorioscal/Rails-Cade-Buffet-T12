RSpec.describe Fine, type: :model do
  describe 'validations' do

    it 'should be valid with valid attributes' do
      fine = Fine.new(status: 'paid', amount: 100, order: Order.new)
      expect(fine).to be_valid
    end

    it 'should be invalid without a status' do
      fine = Fine.new(status: nil)
      expect(fine).to_not be_valid
      expect(fine.errors[:status]).to include("não está incluído na lista")
    end

    it 'should be invalid with an invalid status' do
      fine = Fine.new(status: 'invalid', amount: 100, order: Order.new)
      expect(fine).to_not be_valid
      expect(fine.errors[:status]).to include("não está incluído na lista")
    end

    it 'should be invalid without an amount' do
      fine = Fine.new(status: 'paid', order: Order.new)
      expect(fine).to_not be_valid
      expect(fine.errors[:amount]).to include("não pode ficar em branco")
    end

    it 'should be invalid with a non-positive amount' do
      fine = Fine.new(status: 'paid', amount: -100, order: Order.new)
      expect(fine).to_not be_valid
      expect(fine.errors[:amount]).to include("deve ser maior que 0")
    end
  end
end
