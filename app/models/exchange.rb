# frozen_string_literal: true

class Exchange < ApplicationRecord
  has_many :participation
  has_many :users, through: :participation
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :country, presence: true
  validates :department, presence: true

  def match_ready_participants
    participation.where('is_matched IS ? AND is_match_ready IS ?', false, true)
  end
end
