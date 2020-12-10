# frozen_string_literal: true

class AddMatchedColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :participations, :is_matched, :boolean, null: false, default: false
  end
end
