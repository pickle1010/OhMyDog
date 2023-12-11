class MyControllerPdfController < ApplicationController
  def generate_pdf
    start_of_month = Time.now.beginning_of_month
    end_of_month = Time.now.end_of_month
    @credit_cards = CreditCard.where(created_at: start_of_month..end_of_month)
    @credit_cards = @credit_cards.order(created_at: :desc)

    @total_amount = 0
    for credit_card in @credit_cards do
      @total_amount += credit_card.amount
    end

    respond_to do |format|
      format.html
      format.pdf do
        pdf = CreditCardPdf.new(@credit_cards, @total_amount)
        send_data pdf.render, filename: "credit_cards_report.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end
end