class AdoptionPostsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index ]
  before_action :set_adoption_post, only: %i[ show edit update destroy ]

  # GET /adoption_posts or /adoption_posts.json
  def index
    @adoption_posts = AdoptionPost.all
  end

  # GET /adoption_posts/1 or /adoption_posts/1.json
  def show
  end

  # GET /adoption_posts/new
  def new
    @adoption_post = AdoptionPost.new
    @adoption_post.user_id = current_user.id
  end

  # GET /adoption_posts/1/edit
  def edit
  end

  # POST /adoption_posts or /adoption_posts.json
  def create
    @adoption_post = AdoptionPost.new(adoption_post_params)
    @adoption_post.user_id = current_user.id

    respond_to do |format|
      if @adoption_post.save
        format.html { redirect_to adoption_posts_path, success: "Publicación de Adopción agregada exitosamente." }
        format.json { render :show, status: :created, location: @adoption_post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @adoption_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adoption_posts/1 or /adoption_posts/1.json
  def update
    respond_to do |format|
      if @adoption_post.update(adoption_post_params)
        format.html { redirect_to adoption_posts_path, success: "Publicación de Adopción editada exitosamente." }
        format.json { render :show, status: :ok, location: @adoption_post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @adoption_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adoption_posts/1 or /adoption_posts/1.json
  def destroy
    @adoption_post.destroy!

    respond_to do |format|
      format.html { redirect_to adoption_posts_url, success: "Publicación de Adopción eliminada exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adoption_post
      @adoption_post = AdoptionPost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def adoption_post_params
      params.require(:adoption_post).permit(:body, :user_id)
    end
end
