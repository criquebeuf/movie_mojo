class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.text :overview
      t.string :image
      t.float :rating_api
      t.float :rating_user
      t.text :comment_user
      t.date :date
      t.string :genres
      t.boolean :adult
      t.string :language
      t.date :release_date
      t.integer :runtime

      t.timestamps
    end
  end
end
