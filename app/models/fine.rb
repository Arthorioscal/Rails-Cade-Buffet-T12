class Fine < ApplicationRecord
  belongs_to :order


  validates :status, inclusion: { in: %w[paid unpaid] }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
