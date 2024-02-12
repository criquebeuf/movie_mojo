class MoviesController < ApplicationController
  before_action :set_questionnaire, only: [:create]

  def create
    # questionnaires results is an array of strings
    # eval will create a hash from the string elements that were saved in the results
    @movie = eval(@questionnaire.results.first)
    @movie_db = Movie.new

    # since movie has a lot more keys from the api, we need to check if
    # the key is also available in our movie model, if so: write the attribute
    @movie.each do |key, value|
      if Movie.column_names.include?(key) && key != "id"
        @movie_db[key] = value
      end
    end
    # raise
    if @movie_db.save
      @watched_movie = WatchedMovie.new(user_id: current_user.id, movie: @movie_db)
      # raise
      @watched_movie.save
    else
      # render :new
    end
  end

  private

  def set_questionnaire
    @questionnaire = current_user.questionnaires.last
  end
end
