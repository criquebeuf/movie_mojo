class UsersController < ApplicationController
  def show
    @user = current_user
    @movies = @user.movies
    @rating = Rating.new(params[:score])
    @watched_movies = @user.watched_movies

    if params[:query].present?
      searched_results = Movie.search_by_title_and_overview(params[:query]).pluck(:id)
      watched_movie_ids = @user.watched_movies
      @watched_movies = watched_movie_ids.where(id: searched_results)
    else
      @watched_movies
    end
  end

  def destroy
    @user = current_user
    if @user.delete
      redirect_to new_user_registration_path
    end
  end

  def watched_movies
    @user = current_user
    @movies = @user.watched_movies
  end
end
