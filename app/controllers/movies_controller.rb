class MoviesController < ApplicationController
  before_action :set_questionnaire, only: [:create]

  def create
    @movie = eval(@questionnaire.results.first)
    @movie_db = Movie.new

    @movie.each do |key, value|
      if Movie.column_names.include?(key) && key != "id"
        @movie_db[key] = value
      end
    end
    # raise
    if @movie_db.save
      @watched_movie = WatchedMovie.new(user_id: current_user.id, movie: @movie_db)
      raise
      @watched_movie.save
    else
      render :new
    end
    raise
  end

  private

  def set_questionnaire
    @questionnaire = current_user.questionnaires.last
  end
end
