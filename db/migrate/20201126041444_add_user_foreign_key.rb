# frozen_string_literal: true

class AddUserForeignKey < ActiveRecord::Migration[6.0]
  def change
    add_reference :participations, :user, foreign_key: true, type: :uuid
    add_reference :participations, :exchange, foreign_key: true, type: :uuid
  end
end
