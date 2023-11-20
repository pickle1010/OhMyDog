class TurnFormsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_not_admin, only:[:new, :create]
  before_action :set_turn_form, only: %i[ show edit update destroy confirm reject]

  # GET /turn_forms or /turn_forms.json
  def index
    @turn_forms = current_user.admin? ? TurnForm.all : current_user.turn_forms
  end

  # GET /turn_forms/1 or /turn_forms/1.json
  def show
    redirect_to turn_form_path unless current_user.admin? || @turn_form.user == current_user
  end

  # GET /turn_forms/new
  def new
    @turn_form = TurnForm.new
  end

  # GET /turn_forms/1/edit
  def edit
  end

  # POST /turn_forms or /turn_forms.json
  def create
    @turn_form = TurnForm.new(turn_form_params)
    @turn_form.set_user(current_user)
    selected_service_ids = params[:turn_form][:service_ids]
    selected_services = Service.where(id: selected_service_ids)

    # Actualizar ServiceCons con los nombres de los servicios seleccionados
    @turn_form.servicesCons = selected_services.pluck(:name).join(', ')

    respond_to do |format|
      if @turn_form.save
        format.html { redirect_to turn_form_url(@turn_form), notice: "Turn form was successfully created." }
        format.json { render :show, status: :created, location: @turn_form }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @turn_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turn_forms/1 or /turn_forms/1.json
  def update
    respond_to do |format|
      if @turn_form.update(turn_form_params)
        format.html { redirect_to turn_form_url(@turn_form), notice: "Turn form was successfully updated." }
        format.json { render :show, status: :ok, location: @turn_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @turn_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /turn_forms/1 or /turn_forms/1.json
  def destroy
    @turn_form.destroy!

    respond_to do |format|
      format.html { redirect_to turn_forms_url, notice: "Turn form was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def confirm
    @turn_form.update(confirmed: true)
    redirect_to turn_forms_url, notice: "Turno confirmado exitosamente."
  end
  
  def reject
    @turn_form.destroy
    redirect_to turn_forms_url, notice: "Turno rechazado exitosamente."
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn_form
      @turn_form = TurnForm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turn_form_params
      params.require(:turn_form).permit(:dateCons, :scheduleCons, :descriptionCons, :servicesCons, :confirmed)
    end

    def check_if_not_admin
      redirect_to turn_forms_path if current_user.admin?
    end
end
