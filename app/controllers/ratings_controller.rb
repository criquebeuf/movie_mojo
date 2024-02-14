class RatingsController < ApplicationController

  def create
    @movie = WatchedMovie.find(params[:watched_movie_id])
    @rating = Rating.find_by(watched_movie: @movie, user: current_user)
    if @rating.present?
      @rating.update(ratings_params)
    else
      @rating = Rating.new(ratings_params)
      @rating.watched_movie = @movie
      @rating.user = current_user
    end
    if @rating.save
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Something went wrong"
    end
  end

  private

  def ratings_params
    params.require(:rating).permit(:score)
  end
end
