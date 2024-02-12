class ChangeMovies < ActiveRecord::Migration[7.1]
  def change
    change_table :movies do |t|
      t.rename :image, :poster_path
      t.rename :language, :original_language
      t.rename :date, :date_added
    end
  end
end
