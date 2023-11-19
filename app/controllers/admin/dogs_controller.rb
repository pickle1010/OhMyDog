class Admin::DogsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin, except: %i[ index show ]
  before_action :set_user
  before_action :set_dog, only: %i[ show edit update destroy ]

  # GET /dogs or /dogs.json
  def index
    redirect_to root_path unless current_user.admin? || @user == current_user
    @dogs = @user.dogs
  end

  # GET /dogs/1 or /dogs/1.json
  def show
    redirect_to root_path unless current_user.admin? || @dog.user == current_user
  end

  # GET /dogs/new
  def new
    @dog = Dog.new(user_id: @user.id)
  end  

  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs or /dogs.json
  def create
    @dog = Dog.new(dog_params.merge(user_id: @user.id))

    respond_to do |format|
      if @dog.save
        format.html { redirect_to admin_user_dog_url(user_id: @dog.user_id, id: @dog.id), success: 'El perro fue creado exitosamente' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1 or /dogs/1.json
  def update
    respond_to do |format|
      if @dog.update(dog_params)
        format.html { redirect_to admin_user_dog_path(user_id: @user.id, id: @dog.id), success: "El perro fue actualizado exitosamente" }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1 or /dogs/1.json
  def destroy
    @dog.destroy!

    respond_to do |format|
      format.html { redirect_to admin_user_dogs_path(@user.id), success: "El perro fue eliminado exitosamente" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = @user.dogs.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def dog_params
      params.require(:dog).permit(:photo, :first_name, :last_name, :breed, :color, :sex, :birthday, :user_id)
    end
end
