class CreditCard < ApplicationRecord
    validates :card_type, :card_number, :name, :last_name, :expiration_date, :amount, presence: true
    validates :card_number, presence: true, length: { is: 16 }
end
