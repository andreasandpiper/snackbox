class AddParticipationDetailsComplete < ActiveRecord::Migration[6.0]
  def change
    add_column :participations, :is_match_ready, :boolean, null: false, default: false
  end
end
