class CreateParticipation < ActiveRecord::Migration[6.0]
  def change
    create_table :participations, id: :uuid do |t|
      t.boolean "shipped", :default => false
      t.string "address_1"
      t.string "address_2"
      t.string "city"
      t.string "state"
      t.string "zipcode"
      t.string "country"
      t.string "preferences"
      t.string "team"
      t.string "full_name"
      t.uuid "match_participation_id"
    end
  end
end
