class WatchedMovie < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :movie, uniqueness: { scope: :user }
end
