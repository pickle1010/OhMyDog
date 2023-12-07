class MeetingsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :check_if_admin, except: %i[ index show ]
  before_action :set_meeting, only: %i[ show edit update destroy ]

  # GET /meetings or /meetings.json
  def index
    if !user_signed_in?
      @meetings = Meeting.where.not(name: [:Vacunacion, :Turno])
    elsif current_user.admin?
      @meetings = Meeting.where.not(name: [:Vacunacion])
    else
      @meetings = Meeting.where.not(name: [:Vacunacion, :Turno]).or(current_user.meetings)
    end
  end

  # GET /meetings/1 or /meetings/1.json
  def show
    #@meeting = Meeting.find(params[:id])
    #@blocked_dates = @meeting.turn_forms.pluck(:start_time)
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings or /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to meeting_url(@meeting), success: "El evento fue creado exitosamente." }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meeting_url(@meeting), success: "El evento fue actualizado exitosamente." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @meeting.destroy!

    respond_to do |format|
      format.html { redirect_to meetings_url, success: "El evento fue eliminado exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:name, :start_time, :description)
    end
end
