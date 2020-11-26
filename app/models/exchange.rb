class Exchange < ApplicationRecord
    has_many :participation
    validates :name, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :country, presence: true
    validates :department, presence: true
end
  