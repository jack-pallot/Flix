class MoviesController < ApplicationController
  def index
    @movies = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(allowed_params)
    @movie.save
    if @movie.save
      redirect_to @movie, notice: "Movie successfully added!"
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update(allowed_params)
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url, alert: "Movie successfully deleted!"
  end

  private
    def allowed_params
      params.require(:movie).permit(
        :title,
        :description,
        :rating,
        :total_gross,
        :released_on,
        :duration,
        :director,
        :image_file_name
      )
    end
end
