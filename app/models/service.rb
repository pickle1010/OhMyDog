class Service < ApplicationRecord
    validates :name , presence: true, uniqueness: true
    validates :name , format: { with: /\A[^0-9]+\z/, message: "solo permite ingresar letras"}
    validates :price, presence: true, numericality: {only_float: true}
end
