class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: [:show]
  before_action :set_first_question, only: [:create, :show]

  def index
    @questionnaires = Questionnaire.all
  end

  def show
  end

  def new
    @questionnaire = Questionnaire.new
  end

  def create
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

  def questionnaire_params
    params.require(:questionnaire).permit(:title)
  end

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def set_first_question
    @question = Question.new(content: Question::QUESTIONS[0])
  end
end
