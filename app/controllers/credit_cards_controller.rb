class CreditCardsController < ApplicationController
    before_action :set_credit_card, only: [:show, :edit, :update, :destroy]
  
    # GET /credit_cards
    def index
      @credit_cards = CreditCard.all
    end
  
    # GET /credit_cards/1
    def show
    end
  
    # GET /credit_cards/new
    def new
      @credit_card = CreditCard.new
    end
  
    # GET /credit_cards/1/edit
    def edit
    end
  
    # POST /credit_cards
    def create
      @credit_card = current_user.credit_cards.new(credit_card_params)
  
      respond_to do |format|
        if @credit_card.save
          twenty_percent = (@credit_card.amount * 0.2).round(2)
          current_user.update(positive_balance: current_user.positive_balance + twenty_percent)

          format.html { redirect_to credit_card_url(@credit_card), notice: "Muchas gracias por la donacion! Revise su perfil para ver su saldo a favor" }
          format.json { render :show, status: :created, location: @credit_card }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @credit_card.errors, status: :unprocessable_entity }
        end
      end
    end

  
    # PATCH/PUT /credit_cards/1
    def update
      if @credit_card.update(credit_card_params)
        redirect_to @credit_card, notice: 'Credit card was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /credit_cards/1
    def destroy
      @credit_card.destroy
      redirect_to credit_cards_url, notice: 'Credit card was successfully destroyed.'
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card
      @credit_card = CreditCard.find(params[:id])
    end
  
    # Only allow a list of trusted parameters through.
    def credit_card_params
      params.require(:credit_card).permit(:number, :expiration_month, :expiration_year, :cvv, :name, :last_name, :amount, :card_type)
    end
  end
  