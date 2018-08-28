class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.order(:rating).select(:rating).map(&:rating).unique
    @check_ratings = check
    @checked_rating.each do |rating|
      params[rating] = true
    end

    if params[:title] == "sort"
      @movies = Movie.all.order(:title => "ASC")
      @title_header_class= "hilite"
    elsif params[:release_date] == "sort"
      @movies = Movie.all.order(:release_date => "DESC")
      @release_date_class="hilite"

    else
    @movies = Movie.where(:rating => @checked_ratings)
  end
end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

   private

  def check
    if params[:ratings]
      params[:ratings].keys
    else
      @all_ratings
    end
  end

end
