class ClinicDogsController < ApplicationController
  before_action :set_clinic_dog, only: %i[ show edit update destroy ]

  # GET /clinic_dogs or /clinic_dogs.json
  def index
    @clinic_dogs = ClinicDog.all
  end

  # GET /clinic_dogs/1 or /clinic_dogs/1.json
  def show
  end

  # GET /clinic_dogs/new
  def new
    @clinic_dog = ClinicDog.new
  end

  # GET /clinic_dogs/1/edit
  def edit
  end

  # POST /clinic_dogs or /clinic_dogs.json
  def create
    @clinic_dog = ClinicDog.new(clinic_dog_params)

    respond_to do |format|
      if @clinic_dog.save
        format.html { redirect_to clinic_dog_url(@clinic_dog), notice: "Clinic dog was successfully created." }
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
        format.html { redirect_to clinic_dog_url(@clinic_dog), notice: "Clinic dog was successfully updated." }
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
      format.html { redirect_to clinic_dogs_url, notice: "Clinic dog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic_dog
      @clinic_dog = ClinicDog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def clinic_dog_params
      params.require(:clinic_dog).permit(:question, :dateclinic, :description, :vaccines)
    end
end
