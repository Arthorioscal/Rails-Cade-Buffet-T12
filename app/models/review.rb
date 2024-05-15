class Review < ApplicationRecord
  belongs_to :user
  belongs_to :buffet

  validates :user_id, uniqueness: { scope: :buffet_id, message: "Você já avaliou este buffet." }
  validates :rating, :comment, presence: true
  validates :rating, inclusion: { in: 1..5, message: "Avaliação deve ser entre 1 e 5." }
end
