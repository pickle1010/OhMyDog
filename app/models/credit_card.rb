class CreditCard < ApplicationRecord
    validates :number, presence: true, format: { with: /\A\d{16}\z/, message: 'must be a 16-digit number' }, length: { is: 16 }
    validates :expiration_month, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
    validates :expiration_year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: Date.today.year }
    validates :cvv, presence: true, length: { is: 3 }
    validates :name, presence: true
    validates :amount, numericality: { greater_than_or_equal_to: 0 }
    # validates :card_type, numericality: { only_integer: true }
  
    # other validations or model logic
  end
  
  