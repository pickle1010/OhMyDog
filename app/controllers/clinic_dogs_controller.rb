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
        if @clinic_dog.question? 
          schedule_date = @clinic_dog.dateclinic
          age_in_months = @clinic_dog.dog.age_in_months
          if age_in_months > 4
            schedule_date += 1.year
          else
            schedule_date += 21
          end
          vaccine_dose = @clinic_dog.ambas? ? "inmunológica y antirrábica" : t("activerecord.attributes.clinic_dog.vaccines_options.#{@clinic_dog.vaccines}")
          Message.create(user_id: @clinic_dog.dog.user.id, date: schedule_date, title: "¡Hora de vacunar a #{@clinic_dog.dog.first_name}!", content: "#{@clinic_dog.dog.first_name} ya es apto para recibir una dosis de #{vaccine_dose}")
        end
        format.html { redirect_to clinic_dog_url(@clinic_dog), success: "La historia clínica fue creada exitosamente" }
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
        if @clinic.dog.question
          schedule_date = @clinic_dog.dateclinic
          age_in_months = @clinic_dog.dog.age_in_months
          if age_in_months > 4
            schedule_date = schedule_date + 1.year
          elsif age_in_months > 2
            schedule_date = schedule_date + 21
          else 
            schedule_date = @clinic_dog.dog.birthday + 2.months
          end
          vaccine_dose = @clinic_dog.ambas? ? "inmunológica y antirrábica" : t("activerecord.attributes.clinic_dog.vaccines_options.#{@clinic_dog.vaccines}")
          Message.create(user_id: @clinic_dog.dog.user.id, date: schedule_date, title: "¡Hora de vacunar a #{@clinic_dog.dog.first_name}!", content: "#{@clinic_dog.dog.first_name} ya es apto para recibir una dosis de #{vaccine_dose}")
        end
        format.html { redirect_to clinic_dog_url(@clinic_dog), success: "La historia clínica fue actualizada exitosamente." }
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
      params.require(:clinic_dog).permit(:question, :dateclinic, :description, :vaccines, :dog_id)
    end
end
