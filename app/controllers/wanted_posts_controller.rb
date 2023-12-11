class WantedPostsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index ]
  before_action :set_wanted_post, only: %i[ show edit update destroy ]

  # GET /wanted_posts or /wanted_posts.json
  def index
    @wanted_posts = WantedPost.all
  end

  # GET /wanted_posts/1 or /wanted_posts/1.json
  def show
  end

  # GET /wanted_posts/new
  def new
    @wanted_post = WantedPost.new
    @wanted_post.user_id = current_user.id
  end

  # GET /wanted_posts/1/edit
  def edit
  end

  # POST /wanted_posts or /wanted_posts.json
  def create
    @wanted_post = WantedPost.new(wanted_post_params)
    @wanted_post.user_id = current_user.id

    respond_to do |format|
      if @wanted_post.save
        format.html { redirect_to wanted_posts_path, success: "Publicación de Perdidos y Encontrados agregada exitosamente." }
        format.json { render :show, status: :created, location: @wanted_post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wanted_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wanted_posts/1 or /wanted_posts/1.json
  def update
    respond_to do |format|
      if @wanted_post.update(wanted_post_params)
        format.html { redirect_to wanted_posts_path, success: "Publicación de Perdidos y Encontrados actualizada exitosamente." }
        format.json { render :show, status: :ok, location: @wanted_post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wanted_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wanted_posts/1 or /wanted_posts/1.json
  def destroy
    @wanted_post.destroy!

    respond_to do |format|
      format.html { redirect_to wanted_posts_url, success: "Publicación de Perdidos y Encontrados eliminada exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wanted_post
      @wanted_post = WantedPost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wanted_post_params
      params.require(:wanted_post).permit(:body, :user_id, :photo)
    end
end
