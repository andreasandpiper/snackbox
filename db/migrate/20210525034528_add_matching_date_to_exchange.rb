class AddMatchingDateToExchange < ActiveRecord::Migration[6.0]
  def change
    add_column :exchanges, :match_date, :date, null: false
  end
end
