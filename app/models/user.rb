class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_one :buffet
  has_many :orders

  validates :role, inclusion: { in: ['client', 'buffet_owner'],
  message: "%{value} não é um tipo de usuário válido" }
  validates :role, presence: true
  validates :name, :cpf, presence: true, if: :client_role?
  validates :cpf, uniqueness: true, if: :client_role?
  validates :cpf, cpf: { message: 'Inválido, tente novamente.' }  
  
  def client_role?
    role == 'client'
  end
  
  def buffet_owner_role?
    role == 'buffet_owner'
  end
end
