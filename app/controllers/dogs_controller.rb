class DogsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin, except: %i[ index show ]
  before_action :set_user, only: %i[ index new create ]
  before_action :set_dog, only: %i[ show edit update destroy ]

  # GET /user/:user_id/dogs or /user/:user_id/dogs.json
  def index
    redirect_to root_path unless current_user.admin? || @user == current_user
    @dogs = @user.dogs
  end

  # GET /dogs/1 or /dogs/1.json
  def show
    redirect_to root_path unless current_user.admin? || @dog.user == current_user
  end

  # GET /user/:user_id/dogs/new
  def new
    @dog = Dog.new(user_id: @user.id)
  end  

  # GET /dogs/1/edit
  def edit
  end

  # POST /user/:user_id/dogs or /user/:user_id/dogs.json
  def create
    @dog = Dog.new(dog_params.merge(user_id: @user.id))

    respond_to do |format|
      if @dog.save
        if @dog.age_in_months < 2
          schedule_datetime = @dog.birthday.to_datetime + 2.months
          Message.create(user_id: @dog.user.id, datetime: schedule_datetime, title: "¡Hora de vacunar a #{@dog.first_name}!", content: "#{@dog.first_name} ya es apto para recibir una vacuna inmunológica")
          Meeting.create(name: :Vacunacion, user_id: @user.id, dog_id: @dog.id, start_time: schedule_datetime.to_date, description:"#{@dog.first_name} ya es apto para recibir una vacuna inmunológica")
        end
        format.html { redirect_to @dog, success: 'El perro fue creado exitosamente' }
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
        if @dog.age_in_months <= 2
          schedule_datetime = @dog.birthday.to_datetime + 2.months
          Message.create(user_id: @dog.user.id, datetime: schedule_datetime, title: "¡Hora de vacunar a #{@dog.first_name}!", content: "#{@dog.first_name} ya es apto para recibir una vacuna inmunológica")
          @dog.meeting.update(start_time: schedule_datetime.to_date)
        end
        format.html { redirect_to @dog, success: "El perro fue actualizado exitosamente" }
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
      format.html { redirect_to user_dogs_path(@dog.user), success: "El perro fue eliminado exitosamente" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def dog_params
      params.require(:dog).permit(:photo, :first_name, :last_name, :breed, :color, :sex, :birthday, :user_id)
    end
end
