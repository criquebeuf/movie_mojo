class RemoveYearFromMovies < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :year, :integer
  end
end
