class MyPdfDocument < Prawn::Document
    def initialize
      super()
      text '¡Hola, este es mi primer documento PDF con Prawn!'
    end
  end