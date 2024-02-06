class QuestionnairesController < ApplicationController

  def new
    @questionnaire = Questionnaire.new
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])
  end

end
