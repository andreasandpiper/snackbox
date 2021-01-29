class AddVerifyEmailAndExclude < ActiveRecord::Migration[6.0]
  def change
    remove_column :participations, :is_match_ready
    add_column :participations, :exclude, :boolean, null: false, default: false
    add_column :participations, :verified_email, :boolean, null: false, default: false
  end
end
