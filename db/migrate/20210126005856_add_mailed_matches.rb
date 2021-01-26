class AddMailedMatches < ActiveRecord::Migration[6.0]
  def change
    add_column :exchanges, :mailed_matches, :boolean, null: false, default: false
  end
end
