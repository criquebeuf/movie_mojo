class AddStuffToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :director, :string
    add_column :movies, :actor_first, :string
    add_column :movies, :actor_second, :string
    add_column :movies, :id_tmdb, :integer
    add_column :movies, :id_imdb, :string
  end
end
