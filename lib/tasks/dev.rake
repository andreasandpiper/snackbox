# frozen_string_literal: true

namespace :dev do
  desc 'Seeds development environment'
  task seed: :environment do
    exchange = create_exchange
    20.times do
      participation(exchange)
    end
  end
end

TEAMS = [Faker::Color.color_name, Faker::Color.color_name, Faker::Color.color_name, Faker::Color.color_name,
         Faker::Color.color_name].freeze

def create_exchange
  Exchange.create(name: 'Development Test', start_date: Date.today, end_date: Date.tomorrow, country: 'USA',
                  department: 'Test', details: '')
end

def participation(e)
  first_name = Faker::Name.first_name
  user = User.create(email: "#{first_name}@teladochealth.com".downcase)
  e.participation.create(full_name: "#{first_name} #{Faker::Name.last_name}", team: TEAMS[rand(TEAMS.length)],
                         address_1: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zipcode: Faker::Address.zip, country: Faker::Address.country, user_id: user.id)
end
