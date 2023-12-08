class ClinicDogsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin, except: %i[ index show ]
  before_action :set_dog, only: %i[ index new create ]
  before_action :set_clinic_dog, only: %i[ show edit update destroy ]
  

  # GET /clinic_dogs or /clinic_dogs.json
  def index
    redirect_to root_path unless current_user.admin? || @dog.user == current_user
    @clinic_dogs = @dog.clinic_dogs.order(dateclinic: :desc)
  end

  # GET /clinic_dogs/1 or /clinic_dogs/1.json
  def show
    redirect_to root_path unless current_user.admin? || @clinic_dog.dog.user == current_user
  end

  # GET /clinic_dogs/new
  def new
    @clinic_dog = ClinicDog.new(dog_id: @dog.id)
  end

  # GET /clinic_dogs/1/edit
  def edit
  end

  # POST /clinic_dogs or /clinic_dogs.json
  def create
    @clinic_dog = ClinicDog.new(clinic_dog_params.merge(dog_id: @dog.id))

    respond_to do |format|
      if @clinic_dog.save
        if @clinic_dog.rabies_applied || @clinic_dog.inmunological_applied
          age_in_months = @clinic_dog.dog.age_in_months
          if age_in_months > 2
            schedule_datetime = @clinic_dog.dateclinic.to_datetime
            if age_in_months > 4
              schedule_datetime += 1.year
            else
              schedule_datetime += 21
            end
            if @clinic_dog.rabies_applied && @clinic_dog.inmunological_applied
              vaccines_applied = "antirrábica e inmunológica"
            elsif @clinic_dog.rabies_applied
              vaccines_applied = "antirrábica"
            else
              vaccines_applied = "inmunológica"
            end
            Message.create(user_id: @dog.user.id, clinic_dog_id: @clinic_dog.id, datetime: schedule_datetime, title: "¡Hora de vacunar a #{@clinic_dog.dog.first_name}!", content: "#{@clinic_dog.dog.first_name} ya es apto para recibir una nueva dosis de #{vaccines_applied}")
            Meeting.create(name: :Vacunacion, user_id: @dog.user.id, clinic_dog_id: @clinic_dog.id, start_time: schedule_datetime.to_date, description: "#{@clinic_dog.dog.first_name} ya es apto para recibir una nueva dosis de #{vaccines_applied}")
          end
        end
        format.html { redirect_to clinic_dog_url(@clinic_dog), success: "La nueva entrada fue agregada a la historia clínica exitosamente" }
        format.json { render :show, status: :created, location: @clinic_dog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @clinic_dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinic_dogs/1 or /clinic_dogs/1.json
  def update
    respond_to do |format|
      if @clinic_dog.update(clinic_dog_params)
        if @clinic_dog.rabies_applied || @clinic_dog.inmunological_applied
          age_in_months = @clinic_dog.dog.age_in_months
          if age_in_months > 2
            schedule_datetime = @clinic_dog.dateclinic.to_datetime
            if age_in_months > 4
              schedule_datetime += 1.year
            else
              schedule_datetime += 21
            end
            if @clinic_dog.rabies_applied && @clinic_dog.inmunological_applied
              vaccines_applied = "antirrábica e inmunológica"
            elsif @clinic_dog.rabies_applied
              vaccines_applied = "antirrábica"
            else
              vaccines_applied = "inmunológica"
            end
            unless @clinic_dog.message.nil?
              @clinic_dog.message.update(datetime: schedule_datetime, content: "#{@clinic_dog.dog.first_name} ya es apto para recibir una nueva dosis de #{vaccines_applied}")
            else 
              Message.create(user_id: @clinic_dog.dog.user.id, clinic_dog_id: @clinic_dog.id, datetime: schedule_datetime, title: "¡Hora de vacunar a #{@clinic_dog.dog.first_name}!", content: "#{@clinic_dog.dog.first_name} ya es apto para recibir una nueva dosis de #{vaccines_applied}")
            end
            unless @clinic_dog.meeting.nil?
              @clinic_dog.meeting.update(start_time: schedule_datetime.to_date, description: "#{@clinic_dog.dog.first_name} ya es apto para recibir una nueva dosis de #{vaccines_applied}")
            else
              Meeting.create(name: :Vacunacion, user_id: @clinic_dog.dog.user.id, clinic_dog_id: @clinic_dog.id, start_time: schedule_datetime.to_date, description: "#{@clinic_dog.dog.first_name} ya es apto para recibir una nueva dosis de #{vaccines_applied}")
            end            
          end
        else
          unless @clinic_dog.message.nil?
            @clinic_dog.message.destroy
          end
          unless @clinic_dog.meeting.nil?
            @clinic_dog.meeting.destroy
          end
        end
        format.html { redirect_to clinic_dog_url(@clinic_dog), success: "La entrada de la historia clínica fue actualizada exitosamente." }
        format.json { render :show, status: :ok, location: @clinic_dog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @clinic_dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinic_dogs/1 or /clinic_dogs/1.json
  def destroy
    @clinic_dog.destroy!

    respond_to do |format|
      format.html { redirect_to clinic_dogs_url, success: "La historia clínica fue eliminada exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic_dog
      @clinic_dog = ClinicDog.find(params[:id])
    end

    def set_dog
      @dog = Dog.find(params[:dog_id])
    end

    # Only allow a list of trusted parameters through.
    def clinic_dog_params
      params.require(:clinic_dog).permit(:dateclinic, :description, :rabies_batch, :rabies_dosage, :inmunological_batch, :inmunological_dosage, :dog_id)
    end
end
