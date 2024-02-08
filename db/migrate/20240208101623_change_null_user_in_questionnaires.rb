class ChangeNullUserInQuestionnaires < ActiveRecord::Migration[7.1]
  def change
    change_column_null :questionnaires, :user_id, true
  end
end
