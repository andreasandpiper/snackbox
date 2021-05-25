# frozen_string_literal: true

class Exchange < ApplicationRecord
  has_many :participation
  validates :name, presence: true
  validates :signup_date, presence: true
  validates :ship_date, presence: true
  validates :country, presence: true
  validates :department, presence: true

  scope :most_current_first, -> { order("signup_date DESC") }

  def participants
    participation.joins(:user).order("email ASC")
  end

  def teams_list
    teams.split(",")
  end

  def matched_participants
    participation.where("is_matched is ?", true)
  end

  def participations_not_shipped
    participation.where("shipped is ?", false)
  end
end
