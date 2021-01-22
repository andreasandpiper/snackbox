# frozen_string_literal: true

class Exchange < ApplicationRecord
  has_many :participation
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :country, presence: true
  validates :department, presence: true

  scope :most_current_first, -> { order("start_date DESC") }

  def participants
    participation.joins(:user).order("email ASC")
  end

  def match_ready_participants
    participation.where('is_matched IS ? AND is_match_ready IS ?', false, true)
  end
end
