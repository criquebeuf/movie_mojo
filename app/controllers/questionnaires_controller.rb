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
    # Get the five answers
    @answers = @questionnaire.answers
    # search 1: based on main criteria => return movie_id
    @movie_ids = search_main_params
    # search 2: based on movie_id => return more details (e.g. runtime, actors etc.)
    search_by_movie_id(@movie_ids)

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
    # Returns an array of movie_ids based on basic search (date, genre etc.)
    api_key = ENV['TMDB_KEY']
    url = URI("https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&primary_release_date.gte=#{year_start}&primary_release_date.lte=#{year_end}&with_genres=#{genre_id}&vote_average.gte=#{vote_average}")
    result = search_setup(url, api_key)
    movie_ids = []
    # Check if any results are returned
    if result['results'].any?
      @generated_movies = result['results'].each do |movie|
        movie_ids << movie['id']
      end
    else
      puts "No movie found, please take questionnaire again"
    end
    return movie_ids
  end

  def search_by_movie_id(movie_ids)
    @movies = []
    movie_ids.each do |id|
      # Returns main data
      api_key = ENV['TMDB_KEY']
      url = URI("https://api.themoviedb.org/3/movie/#{id}?language=en-US")
      @movie = search_setup(url, api_key)
      # Returns director info
      url_crew = URI("https://api.themoviedb.org/3/movie/#{id}/credits?language=en-US")
      result = search_setup(url_crew, api_key)
      @crew = result['crew']
      director = @crew.find { |member| member['job'] == "Director" }
      @movie['director'] = director['name'] if director
      # Returns actors info
      @movie['actor_first'] = result['cast'][0]['name']
      @movie['actor_second'] = result['cast'][1]['name']
      @movies << @movie
    end
    @movies
  end

  def year_start
    year = @answers[1].content
    "#{year}-01-01"
  end

  def year_end
    year = @answers[1].content.to_i + 9
    "#{year}-12-31"
  end

  def genre_id
    @answers[0].content
    # genres_id.join(",") # to be added when transformed into multiple select!
  end

  def vote_average
    # Temp value below
    6
  end

  def director

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
