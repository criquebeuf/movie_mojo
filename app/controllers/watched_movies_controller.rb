class WatchedMoviesController < ApplicationController
  before_action :authenticate_user!

  def index
    @watched_movies = current_user.watched_movies
  end

  def create
    @movie = Movie.find(params[:movie_id])
    if current_user.movies.include?(@movie)
      flash[:alert] = 'Movie is already in your watchlist.'
    else
      current_user.movies << @movie
      flash[:notice] = 'Movie added to watchlist.'
    end
    redirect_to watchlist_path
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    if current_user.movies.include?(@movie)
      current_user.movies.delete(@movie)
      flash[:notice] = 'Movie removed from watchlist.'
    else
      flash[:alert] = 'Movie is not in your watchlist.'
    end
    redirect_to watchlist_path
  end

  private

  def watched_movie_params
    params.require(:watched_movie).permit(:movie_id)
  end

end
