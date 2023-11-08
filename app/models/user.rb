class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :registerable, :rememberable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, 
         :validatable, :timeoutable

  validates :dni, :first_name, :last_name, :address, presence: true
  validates :dni, uniqueness: true, numericality: { greater_than: 0 }
end
