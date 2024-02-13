class Question < ApplicationRecord
  belongs_to :questionnaire
  has_one :answer, dependent: :destroy

  QUESTIONS = {
    genre: "What are you in the mood for?",
    decade: "Which decade are you in the mood for today?",
    director: "If you have a favorite director, feel free to share.",
    actor: "If you have a favorite actor or actress, feel free to share.",
    runtime: "How much time do you have today?"
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
    "Less than 30 minutes" => 30,
    "up to 1 hour" => 60,
    "up to 2 hours" => 120,
    "3 hours or so" => 180,
    "All night long!" => 999
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
      # inclusion_source = genre_for_select
      genre_for_select.map { |genre, id| [genre.to_s, id] }
    when :decade
      inclusion_source = DECADES
      DECADES.map { |label, value| [label, value] }
    when :runtime
      inclusion_source = RUNTIMES
      RUNTIMES.map { |label, value| [label, value] }
    end
  end
end
