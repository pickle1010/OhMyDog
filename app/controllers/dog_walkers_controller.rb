class DogWalkersController < ApplicationController
  before_action :set_dog_walker, only: %i[ show edit update destroy ]

  # GET /dog_walkers or /dog_walkers.json
  def index
    @dog_walkers = DogWalker.all
  end

  # GET /dog_walkers/1 or /dog_walkers/1.json
  def show
  end

  # GET /dog_walkers/new
  def new
    @dog_walker = DogWalker.new
  end

  # GET /dog_walkers/1/edit
  def edit
  end

  # POST /dog_walkers or /dog_walkers.json
  def create
    @dog_walker = DogWalker.new(dog_walker_params)

    respond_to do |format|
      if @dog_walker.save
        flash_notice = "El perfil de Paseador/Cuidador fue agregado con éxito"
        format.html { redirect_to dog_walkers_path, success: flash_notice }
        format.json { render :index, status: :created, location: @dog_walker }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dog_walker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dog_walkers/1 or /dog_walkers/1.json
  def update
    respond_to do |format|
      if @dog_walker.update(dog_walker_params)
        format.html { redirect_to dog_walkers_path, success: "El perfil de paseador/cuidador fue actualizado" }
        format.json { render :index, status: :ok, location: @dog_walker }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dog_walker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dog_walkers/1 or /dog_walkers/1.json
  def destroy
    @dog_walker.destroy!

    respond_to do |format|
      format.html { redirect_to dog_walkers_url, success: "El perfil de paseador/cuidador fue eliminado con éxito" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog_walker
      @dog_walker = DogWalker.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dog_walker_params
      params.require(:dog_walker).permit(:name, :lastname, :workplace, :service, :contact, :photo)
    end
end
