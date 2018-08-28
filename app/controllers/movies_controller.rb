class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.order(:rating).select(:rating).map(&:rating).uniq
    @checked_ratings = check
    @checked_ratings.each do |rating|
      params[rating] = true
    if(params[:ratings])
      session[:ratings] = params[:ratings]
      @ratings = params[:ratings].keys
    elsif(session[:ratings])
      if(session[:sort_by].nil?)
          redirect_to movies_path({:ratings => session [:ratings]})
        end
      
    end

    if (params[:sort])
      @sort_by = params[:sort_by]
      session[:sort_by] = @sort_by
      @movies = Movie.order(params[:sort])
      !(rating.nil?) ? @movies = @movies.find_all_by_rating(@ratings): @movies
    elsif(session[:sort_by])
      @sort_by = session[:sort_by]
      redirect_to movies_path({:sort_by => @sort_by, :ratings => session[:ratings] })
    else
      @movies = Movie.where(:rating => @checked_ratings)
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
