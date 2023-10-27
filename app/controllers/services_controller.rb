class ServicesController < ApplicationController
    def edit
        @service = Service.find(params[:id])
    end

    def update
        @service = Service.find(params[:id])
        if @service.update(service_params)
          redirect_to service_path(@service), notice: "El servicio fue modificado exitosamente."
        else
          render 'edit'
        end
    end
      
      private
      
    def service_params
        params.require(:service).permit(:name, :price)
    end
      
end