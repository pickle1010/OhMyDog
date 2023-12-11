class CreditCardPdf < Prawn::Document
    def initialize(credit_cards)
      super()
      @credit_cards = credit_cards
      generate_pdf
    end
  
    def generate_pdf

      title "Informe de Donaciones", size: 18, style: :bold, align: :center
      move_down 5
    
      subtitle "Mes de #{I18n.t('date.month_names')[DateTime.now.month]}", size: 14, align: :center
    
      move_down 15
    
  
      @credit_cards.each do |credit_card|
        text "Monto donado: #{credit_card.amount}"
  
        if credit_card.user.present?
          full_name = "#{credit_card.user.first_name} #{credit_card.user.last_name}"
          text "Cliente: #{full_name}"
        else
          text "Cliente: Anónimo"
        end
  
        text "Fecha: #{credit_card.created_at.strftime("%d/%m/%Y")}"
        move_down 10
      end
    end

    private

    def title(text, options = {})
      text text, options.merge(size: 18, style: :bold, align: :center)
    end
  
    def subtitle(text, options = {})
      text text, options.merge(size: 14, align: :center)
    end

end
  