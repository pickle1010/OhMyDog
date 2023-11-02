class ServicesController < ApplicationController
    def index
        @service = Service.all
    end
 
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

    def toggle_active
        @service = Service.find(params[:id])
        @service.active = !@service.active
        @service.save
        redirect_to service_path(@service), notice: 'Estado del servicio actualizado'
        render json: {active: @service.active}
    end
  end