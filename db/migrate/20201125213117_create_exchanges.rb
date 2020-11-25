class CreateExchanges < ActiveRecord::Migration[6.0]
  def change
    create_table :exchanges, id: :uuid do |t|
      t.string "name", :null => false
      t.date "start_date", :null => false
      t.date "end_date", :null => false
      t.string "country",  :null => false
      t.string "details",  :null => false
      t.string "department",  :null => false
    end
  end
end
