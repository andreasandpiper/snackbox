class ChangeDateColumnNames < ActiveRecord::Migration[6.0]
  def up
    rename_column :exchanges, :start_date, :signup_date
    rename_column :exchanges, :end_date, :ship_date
  end

  def down
    rename_column :exchanges, :signup_date, :start_date
    rename_column :exchanges, :ship_date, :end_date
  end
end
