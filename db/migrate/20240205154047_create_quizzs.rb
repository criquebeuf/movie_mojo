class CreateQuizzs < ActiveRecord::Migration[7.1]
  def change
    create_table :quizzs do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
