class WatchedMovie < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_one :rating

  validates :movie, uniqueness: { scope: :user }

  include PgSearch::Model
  pg_search_scope :search_by_title_and_overview,
  against: [ :title, :overview ],
  using: {
    tsearch: { prefix: true }
  }
end
