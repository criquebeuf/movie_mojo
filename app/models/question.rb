class Question < ApplicationRecord
  belongs_to :questionnaire
  has_one :answer, dependent: :destroy

  QUESTIONS = {
    genre: "What genre do you like?",
    decade: "You like movies of which decade?",
    director: "Do you have a favorite director?",
    actor: "Do you have an favorite actor?",
    runtime: "How much time do you have?"
  }

  GENRES = {
    action: 28,
    adventure: 12,
    animation: 16,
    comedy: 35,
    crime: 80,
    # documentary: 99,
    drama: 18,
    family: 10751,
    fantasy: 14,
    history: 36,
    horror: 27,
    # music: 10402,
    mystery: 9648,
    romance: 10749,
    science_fiction: 878,
    # tv_movie: 10770,
    thriller: 53,
    war: 10752,
    western: 37
  }

  DECADES = {
    "50s" => 1950,
    "60s" => 1960,
    "70s" => 1970,
    "80s" => 1980,
    "90s" => 1990,
    "2000s" => 2000,
    "2010s" => 2010,
    "2020s" => 2020,
  }

  RUNTIMES = {
    "up to 30" => 30,
    "up to 1h" => 60,
    "up to 1.5h" => 90,
    "up to 2h" => 120,
    "all night long" => 999
  }

  validates :content, inclusion: { in: QUESTIONS.values }

  def genre_for_select
    GENRES.transform_keys { |key| key.to_s.titleize }
  end

  # get the questions index everytime you call this function
  # self is the question where this function is called from
  # the first self isn't mandatory, but better for understanding
  def question_index
    self.questionnaire.questions.index(self)
  end

  # to have the correct selection options in the dropdown in the view, the #
  # inclusion source is set individually depending on the question
  def inclusion_source
    case QUESTIONS.key(self.content)
    when :genre
      puts genre_for_select
      inclusion_source = genre_for_select
    when :decade
      inclusion_source = DECADES
    when :runtime
      inclusion_source = RUNTIMES
    end
  end
end
