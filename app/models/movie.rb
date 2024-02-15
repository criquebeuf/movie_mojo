class Movie < ApplicationRecord
  has_many :watched_movies

  include PgSearch::Model
  pg_search_scope :search_by_title_and_overview,
  against: [ :title, :overview ],
  using: {
    tsearch: { prefix: true }
  }
end
