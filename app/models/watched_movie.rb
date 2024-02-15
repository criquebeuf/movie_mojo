class WatchedMovie < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_one :rating, dependent: :destroy

  validates :movie, uniqueness: { scope: :user }

  include PgSearch::Model
  pg_search_scope :search_by_title_and_overview,
  against: [ :title, :overview, :director, :actor_first, :actor_second, :genres ],
  using: {
    tsearch: { prefix: true }
  }
end
