class Participation < ApplicationRecord
    belongs_to :exchange
    belongs_to :user

    validates :full_name, presence: true
    validates :address_1, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zipcode, presence: true
    validates :team, presence: true

    # validate they haven't signed up for exchange yet
end