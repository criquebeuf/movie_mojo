class AnswersController < ApplicationController
  before_action :set_question, only: [:new]
  before_action :set_next_question, only: [:create]

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)

    if @answer.save

    else

    end
    raise
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_next_question
    @next_question = Question.new(content: Question::QUESTIONS[1])
  end
end
