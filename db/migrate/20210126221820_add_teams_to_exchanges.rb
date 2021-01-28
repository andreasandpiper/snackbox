class AddTeamsToExchanges < ActiveRecord::Migration[6.0]
  def change
    add_column :exchanges, :teams, :string
  end
end
