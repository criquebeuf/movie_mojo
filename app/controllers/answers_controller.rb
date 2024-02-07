class AnswersController < ApplicationController
  before_action :set_question, only: [:new, :create, :edit, :update]
  before_action :set_next_question, only: [:create]
  before_action :set_questionnaire, only: [:new, :update, :edit]
  before_action :set_question_index, only: [:new, :edit]
  before_action :set_previous_stuff, only: [:new, :edit]

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.question = @question

    # as we have no validators on answer the save will never fail
    # so we don't need an if statement
    @answer.save
    redirect_to new_question_answer_path(@next_question)
  end

  def edit
    @answer = @question.answer
  end

  def update
    if @question.answer.update(answer_params)
      if @questionnaire.questions.last.answer.present?
        redirect_to edit_question_answer_path(@questionnaire.questions.last.answer)
      else
        redirect_to new_question_answer_path(@questionnaire.questions.last)
      end
    end
    # raise
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end

  def set_questionnaire
    @questionnaire = @question.questionnaire
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_next_question
    next_question_idx = set_questionnaire.questions.count

    if next_question_idx <= Question::QUESTIONS.count - 1
      @next_question = Question.new(content: Question::QUESTIONS[next_question_idx])
      @next_question.questionnaire = @questionnaire
      @next_question.save
    else
      redirect_to questionnaire_path(@questionnaire)
    end
  end

  def set_question_index
    @question_index = @question.question_index
  end

  def set_previous_stuff
    @previous_question = @questionnaire.questions[@question_index - 1]
    @previous_answer = @previous_question.answer
  end
end
