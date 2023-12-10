class TurnFormsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_not_admin, only: [:new, :create, :cancel]
  before_action :check_if_admin, only: [:confirm, :confirm_reject, :reject, :emit_amount, :save_amount]
  before_action :set_turn_form, only: %i[ show edit update destroy confirm reject confirm_reject cancel emit_amount save_amount]

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
    meetings = Meeting.where(name: :No_laborable_todo_el_dia)
    @disabled_dates = meetings.pluck(:start_time)
    # Puedes realizar cualquier formato necesario para las fechas antes de pasarlas a la vista
    @disabled_dates = @disabled_dates.map { |date| date.strftime("%Y-%m-%d") }
  end

  # GET /turn_forms/1/edit
  def edit
  end

  # POST /turn_forms or /turn_forms.json
  def create
    @turn_form = TurnForm.new(turn_form_params)
    @turn_form.set_user(current_user)
    @turn_form.dog = Dog.find(params[:turn_form][:dog_id]) if params[:turn_form][:dog_id].present?
    selected_service_ids = params[:turn_form][:service_ids]
    selected_services = Service.where(id: selected_service_ids)

    # Actualizar ServiceCons con los nombres de los servicios seleccionados
    @turn_form.servicesCons = selected_services.pluck(:name).join(', ')

    respond_to do |format|
      if @turn_form.save
        User.where(role: :admin).each do |admin|
          Message.create(user_id: admin.id, datetime: DateTime.now, title: "Turno solicitado", content: "#{@turn_form.user.first_name} con DNI #{@turn_form.user.dni} ha solicitado un turno para #{@turn_form.dog.first_name}")
        end
        format.html { redirect_to turn_form_url(@turn_form), success: "El turno fue solicitado exitosamente" }
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
        @turn_form.dog = Dog.find(params[:turn_form][:dog_id]) if params[:turn_form][:dog_id].present?
        format.html { redirect_to turn_form_url(@turn_form), success: "La solicitud de turno fue editada exitosamente" }
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
      format.html { redirect_to turn_forms_url, success: "El turno fue destruido exitosamente" }
      format.json { head :no_content }
    end
  end

  def confirm
    @turn_form.update(confirmed: true)
    Meeting.create(name: :Turno, user_id: @turn_form.user.id, turn_form_id: @turn_form.id, start_time: @turn_form.dateCons, description:"Cliente: #{@turn_form.user.first_name} #{@turn_form.user.last_name}, DNI: #{@turn_form.user.dni}, Mascota: #{@turn_form.dog.first_name}")
    Message.create(user_id: @turn_form.user.id, datetime: DateTime.now, title: "Turno confirmado", content: "Tu turno para #{@turn_form.dog.first_name} ha sido confirmado")
    redirect_to turn_forms_url, success: "Turno confirmado exitosamente."
  end

  def reject
    @rejection_message = Message.new
  end
  
  def confirm_reject
    @rejection_message = Message.new(message_params)
    @rejection_message.assign_attributes(user: @turn_form.user, datetime: DateTime.now, title: "Turno rechazado")

    if @rejection_message.valid?
      @rejection_message.content = "Tu turno para #{@turn_form.dog.first_name} ha sido rechazado. Motivo: #{@rejection_message.content}"
      @rejection_message.save
      @turn_form.destroy
      redirect_to turn_forms_url, success: "Turno rechazado exitosamente."
    else
      render :reject, status: :unprocessable_entity
    end
  end

  def cancel
    @turn_form.destroy
    if @turn_form.confirmed
      User.where(role: :admin).each do |admin|
        Message.create(user_id: admin.id, datetime: DateTime.now, title: "Turno cancelado", content: "#{@turn_form.user.first_name} con DNI #{@turn_form.user.dni} ha cancelado el turno para #{@turn_form.dog.first_name}")
      end
    end
    redirect_to turn_forms_url, success: "Turno cancelado exitosamente."
  end
  
  def emit_amount
  end

  def save_amount
    @turn_form.assign_attributes(turn_form_params)

    if @turn_form.valid?(:save_total_amount)
      monto_ingresado = @turn_form.total_amount.to_f
      saldo_a_favor = @turn_form.user.positive_balance.to_f
      
      # Calcula el monto a descontar
      monto_a_descontar = [monto_ingresado - saldo_a_favor, 0].max
    
      # Calcula el saldo a favor a actualizar
      nuevo_saldo_a_favor = saldo_a_favor - monto_ingresado
    
      # Calcula el monto total a actualizar y actualiza el turno con el monto resultante
      # Además, también actualiza el turno con la descripción adicional del veterinario y lo marca como atendido
      @turn_form.update(total_amount: [(monto_ingresado - saldo_a_favor), 0].max, done: true)

      # Si el turno incluye castración, se marca al perro como castrado
      if @turn_form.servicesCons.downcase.include?("Castración".downcase)
        @turn_form.dog.update(castrated: true)
      end
    
      # Actualiza el saldo a favor del cliente
      @turn_form.user.update(positive_balance: [nuevo_saldo_a_favor, 0].max)

      Message.create(user_id: @turn_form.user.id, datetime: DateTime.now, title: "Monto total recibido", content: "El monto total de tu turno para #{@turn_form.dog.first_name} es $#{@turn_form.total_amount}. Descripción adicional del veterinario: #{@turn_form.vet_description}")
      redirect_to turn_forms_path, success: "Monto emitido exitosamente"
    else
      render 'emit_amount', status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn_form
      @turn_form = TurnForm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turn_form_params
      params.require(:turn_form).permit(:dateCons, :schedule, :descriptionCons, :servicesCons, :confirmed, :dog_id, :total_amount, :vet_description)
    end

    def message_params
      params.require(:message).permit(:content)
    end

    def check_if_not_admin
      redirect_to turn_forms_path if current_user.admin?
    end
end