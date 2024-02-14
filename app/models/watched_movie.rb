class WatchedMovie < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_one :rating

  validates :movie, uniqueness: { scope: :user }
end
