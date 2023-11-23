class CreditCardController < ApplicationController
    def new
      @credit_card = CreditCard.new
    end

    def create
        @credit_card = CreditCard.new(credit_card_params)
        #@credit_card.set_user(current_user)
    end

    private
    def credit_card_params
        params.require(:credit_card).permit(:card_type, :card_number, :name, :last_name, :expiration_date, :amount)
      end
end