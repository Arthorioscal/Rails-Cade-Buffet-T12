require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    it "validates presence of rating" do
      user = User.create(name: "se alguem estiver lendo isso sao 4 da manha e eu estou cansado :(")
      buffet = Buffet.create(brand_name: "EU NAO AGUENTO MAIS ESCREVER TESTES")
      review = Review.new(user: user, buffet: buffet, rating: nil)
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("não pode ficar em branco;")
    end

    it "validates presence of comment" do
      user = User.create(name: "UOU :3")
      buffet = Buffet.create(brand_name: "EU NAO AGUENTO MAIS ESCREVER TESTES")
      review = Review.new(user: user, buffet: buffet, comment: nil)
      expect(review).not_to be_valid
      expect(review.errors[:comment]).to include("não pode ficar em branco;")
    end

    it "validates inclusion of rating between 1 and 5" do
      user = User.create(name: "IM GOIN CRAZY")
      buffet = Buffet.create(brand_name: "EU NAO AGUENTO MAIS ESCREVER TESTES")
      review = Review.new(user: user, buffet: buffet, rating: 6)
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include("Avaliação deve ser entre 1 e 5.")
    end
  end
end
