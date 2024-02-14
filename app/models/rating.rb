class Rating < ApplicationRecord
  belongs_to :watched_movie
  belongs_to :user

  validates :watched_movie, uniqueness: { scope: :user }
end
