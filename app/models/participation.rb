# frozen_string_literal: true

class Participation < ApplicationRecord
  belongs_to :exchange
  belongs_to :user

  validates :full_name, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :team, presence: true

  validates :user_id, presence: true,
                      uniqueness: { scope: :exchange, message: 'cannot sign up for the same exchange more than once.' }

  def match
    Participation.find match_participation_id
  end

  def generate_token
    new_token = SecureRandom.alphanumeric(6)
    current_token = ParticipationToken.find_by participation_id: id
    if current_token
      current_token.update token: new_token, expires_at: Time.now + 1.day
    else
      ::ParticipationToken.create token: new_token, participation_id: id,
                                  expires_at: Time.now + 1.day
    end
    new_token
  end
end
