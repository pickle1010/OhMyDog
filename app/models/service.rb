class Service < ApplicationRecord
    validates :name , presence: true, uniqueness: { case_sensitive: false}
    validates :name , format: { with: /\A[^0-9]+\z/, message: "solo permite ingresar letras"}
    validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
