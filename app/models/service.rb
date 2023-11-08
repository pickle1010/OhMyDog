class Service < ApplicationRecord
    validates :name , presence: true, uniqueness: true
    validates :price, presence: true, numericality: {only_float: true}
end
