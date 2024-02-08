require 'uri'
require 'net/http'
require 'json'

class QuestionnairesController < ApplicationController
#  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_questionnaire, only: [:show]
  before_action :set_first_question, only: [:create, :show]

  def index
    @questionnaires = Questionnaire.all
  end

  def show
    # search 1: based on main criteria => return movie_id
    @movie_ids = search_main_params
    # search 2: based on movie_id => return more details (e.g. runtime)
    search_by_movie_id(@movie_ids)
    # search_credits(@movie_ids)
  end

  def new
    @questionnaire = Questionnaire.new
  end

  def create
    # raise
    @questionnaire = Questionnaire.new(title: Time.now)
    @questionnaire.user = current_user

    if @questionnaire.save
      @question.questionnaire = @questionnaire
      @question.save

      redirect_to new_question_answer_path(@question)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  ## START: ALGORYTHM METHODS

  def search_setup(url, api_key)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = "Bearer #{api_key}"

    response = http.request(request)

    # Parse the response body and extract the necessary information
    JSON.parse(response.read_body)
  end

  def search_main_params
    # this method returns an array of movie_ids based on basic search (date, genre etc.)
    api_key = ENV['TMDB_KEY']
    url = URI("https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&primary_release_date.gte=#{year_start}&primary_release_date.lte=#{year_end}&with_genres=#{genre_id}&vote_average.gte=#{vote_average}")
    result = search_setup(url, api_key)
    movie_ids = []
    # Check if any results are returned
    if result['results'].any?
      # Return 3 movies
      @generated_movies = result['results']
      @generated_movies.each do |movie|
        movie_ids << movie['id']
      end
    else
      puts "No movie found, please take questionnaire again"
    end
    return movie_ids
  end

  def search_by_movie_id(movie_ids)
    @movies = []
    @movie_ids.each do |id|
      api_key = ENV['TMDB_KEY']
      url = URI("https://api.themoviedb.org/3/movie/#{id}?language=en-US")
      movie = search_setup(url, api_key)
      @movies << movie
    end
    @movies
  end

  # def search_credits(movie_ids)
  #   @credits = []
  #   @movie_ids.each do |id|
  #     api_key = ENV['TMDB_KEY']
  #     url = URI("https://api.themoviedb.org/3/movie/#{id}/credits?language=en-US")
  #     crew = search_setup(url, api_key)
  #     @credits << crew
  #   end
  #   @credits
  # end

  def year_start
    # TO DO: use release date instead (year does not seem to be the release year)
    # Temp value below
    year = 2022
    "#{year}-01-01"
  end

  def year_end
    # TO DO: use release date instead (year does not seem to be the release year)
    # Temp value below
    year = 2022
    "#{year}-12-31"
  end

  def genre_id
    # TO DO: retrieve genre_ids from API (https://api.themoviedb.org/3/genre/movie/list?)
    # Temp value below (array)
    genres_id = [18, 53]
    genres_id.join(",")
  end

  def vote_average
    # Temp value below
    5
  end

  ## END: ALGORYTHM METHODS

  def questionnaire_params
    params.require(:questionnaire).permit(:title)
  end

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def set_first_question
    @question = Question.new(content: Question::QUESTIONS[:genre])
  end
end
