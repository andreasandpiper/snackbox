class CreateParticipation < ActiveRecord::Migration[6.0]
  def change
    create_table :participation, id: :uuid do |t|
      t.boolean "shipped", :default => false
      t.string "address_1"
      t.string "address_2"
      t.string "city"
      t.string "state"
      t.string "zipcode"
      t.string "country"
      t.string "preferences"
      t.references :users, foreign_key: true, index: true, type: :uuid
    end
  end
end
