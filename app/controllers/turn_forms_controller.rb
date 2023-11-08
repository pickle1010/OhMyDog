class TurnFormsController < ApplicationController
  before_action :set_turn_form, only: %i[ show edit update destroy ]

  # GET /turn_forms or /turn_forms.json
  def index
    @turn_forms = TurnForm.all
  end

  # GET /turn_forms/1 or /turn_forms/1.json
  def show
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn_form
      @turn_form = TurnForm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turn_form_params
      params.require(:turn_form).permit(:DateCons, :ScheduleCons, :descriptionCons)
    end
end
