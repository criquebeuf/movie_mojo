class MoviesController < ApplicationController
  before_action :set_questionnaire, only: [:create]

  def create
    # puts params
    # questionnaires results is an array of strings
    # eval will create a hash from the string elements that were saved in the results
    # @movie_api = eval(@questionnaire.results.first)

    # map the attributes between the movie coming from the api and the movie model in our db
    # @movie_db = map_movie_attributes(@movie_api)
    @movie_db = map_movie_attributes(params)

    # mark the movie as watched, create this movie in the db if not already present
    save_watched_movie(@movie_db)

    respond_to do |format|
      format.json { render json: { movie: @movie_db } }
    end
  end

  private

  def set_questionnaire
    @questionnaire = current_user.questionnaires.last
  end

  def map_movie_attributes(movie_api)
    # since movie has a lot more keys from the api, we need to check if
    # the key is also available in our movie model, if so: write the attribute
    @movie_db = Movie.new
    movie_api.each do |key, value|
      # case for some special attributes that require a mapping
      case key
      when "id"
        @movie_db[:id_tmdb] = value
      when "imdb_id"
        @movie_db[:id_imdb] = value
      when "vote_average"
        @movie_db[:rating_api] = value
      else
        if Movie.column_names.include?(key)
          @movie_db[key] = value
        end
      end
    end

    @movie_db[:date_added] = Time.now
    @movie_db
  end

  def save_watched_movie(movie_db)
    # is this movie already in our db?
    movie_present = Movie.find_by(id_imdb: movie_db.id_imdb)

    if movie_present
      @watched_movie = WatchedMovie.new(user_id: current_user.id, movie: movie_present)
    else
      @movie_db.save
      @watched_movie = WatchedMovie.new(user_id: current_user.id, movie: @movie_db)
    end

    @watched_movie.save
  end
end
