class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin, except: %i[ show ]
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :allow_without_password, only: [:update]

  # GET /users or /users.json
  def index
    @users = User.where(role: :client).order(:dni)
  end

  # GET /users/1 or /users/1.json
  def show
    redirect_to root_path unless current_user.admin? || @user == current_user
  end

  # GET /users/new
  def new
    @user = User.new
    @user.dogs.build
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    existing_user = User.find_by(dni: user_params[:dni])

    if existing_user
      redirect_to user_url(existing_user), danger: "Cliente con DNI #{existing_user.dni} ya existe. Redirigido al cliente existente..."
      return
    end

    existing_user = User.find_by(email: user_params[:email])

    if existing_user
      redirect_to user_url(existing_user), danger: "Cliente con email #{existing_user.email} ya existe. Redirigido al cliente existente..."
      return
    end

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save        
        format.html { redirect_to new_user_dog_path(@user.id), success: "El cliente y su mascota fueron creados exitosamente. Puede seguir agregando mascotas..."}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), success: "El cliente fue actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, success: "El cliente fue eliminado exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :dni, :first_name, :last_name, :address, :role, dogs_attributes: [:id, :photo, :first_name, :last_name, :breed, :color, :sex, :birthday])
    end

    def allow_without_password
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
      end
    end
end
