class Questionnaire < ApplicationRecord
  belongs_to :user, optional: true
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions
end
