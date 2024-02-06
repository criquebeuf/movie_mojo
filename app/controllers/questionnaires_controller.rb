class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: [:show]
  before_action :set_questions, only: [:create]

  def index
    @questionnaires = Questionnaire.all
  end

  def show
  end

  def new
    @questionnaire = Questionnaire.new
    # @answer = Answer.new
  end

  def create
    @questionnaire = Questionnaire.new(title: Time.now)
    @questionnaire.user = current_user

    if @questionnaire.save
      @questions.each do |question|
        question.questionnaire = @questionnaire
        question.save
      end

      redirect_to questionnaire_path(@questionnaire)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def questionnaire_params
    params.require(:questionnaire).permit(:title)
  end

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def set_questions
    @questions = []
    Question::QUESTIONS.each do |question|
      @questions << Question.new(content: question)
    end
  end
end
