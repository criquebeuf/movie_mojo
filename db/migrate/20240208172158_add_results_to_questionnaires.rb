class AddResultsToQuestionnaires < ActiveRecord::Migration[7.1]
  def change
    add_column :questionnaires, :results, :string, array: true, default: []
  end
end
