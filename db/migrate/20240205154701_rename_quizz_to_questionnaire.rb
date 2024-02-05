class RenameQuizzToQuestionnaire < ActiveRecord::Migration[7.1]
  def change
    rename_table :quizzs, :questionnaires
  end
end
