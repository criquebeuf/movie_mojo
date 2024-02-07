class Question < ApplicationRecord
  belongs_to :questionnaire
  has_one :answer, dependent: :destroy

  QUESTIONS = [
    "What genre do you like?",
    "You like movies of which decade?",
    "Do you have a favorite director?"
  ]

  validates :content, inclusion: { in: QUESTIONS }
end
