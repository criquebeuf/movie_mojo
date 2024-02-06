class Question < ApplicationRecord
  belongs_to :questionnaire
  has_one :answer, dependent: :destroy

  QUESTIONS = [
    "What genre do you like?",
    "You like movies of which decade?"
  ]

  validates :content, inclusion: { in: QUESTIONS }
end
