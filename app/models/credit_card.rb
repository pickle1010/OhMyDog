class CreditCard < ApplicationRecord
    belongs_to :user, optional: true 
    validates :number, presence: true, format: { with: /\A\d{16}\z/, message: 'must be a 16-digit number' }, length: { is: 16 }
    validates :expiration_month, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
    validates :expiration_year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: Date.today.year }
    validates :cvv, presence: true, numericality: { in:100..999 }
    validates :name, presence: true, format: { with: /\A[A-Za-z\s]+\z/, message: "solo permite letras" }
    validates :last_name, presence: true, format: { with: /\A[A-Za-z\s]+\z/, message: "solo permite letras" }
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validate :month_cannot_be_in_the_past
    # validates :card_type, numericality: { only_integer: true }
  
    def month_cannot_be_in_the_past
      if expiration_month.present? && expiration_month < Date.today.month && expiration_year.present? && expiration_year <= Date.today.year
        errors.add(:base, "Debe ser una tarjeta vigente")
      end
    end

end
  