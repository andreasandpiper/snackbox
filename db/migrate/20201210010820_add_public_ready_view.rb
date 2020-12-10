# frozen_string_literal: true

class AddPublicReadyView < ActiveRecord::Migration[6.0]
  def change
    add_column :exchanges, :is_matching_viewable, :boolean, null: false, default: false
  end
end
