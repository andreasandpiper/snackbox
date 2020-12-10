namespace :dev do
  desc 'Seeds development environment'
  task seed: :environment do
    exchange = create_exchange
    20.times do
        participation(exchange)
    end

  end
end

def create_exchange
  Exchange.create(name: "Development Test", start_date: Date.today, end_date: Date.tomorrow, country: "USA", department: "Test", details: "" )
end

def participation(e)
  user = User.create(email: "#{Faker::Name.first_name}@teladochealth.com")
  e.participation.create(full_name: Faker::Name.name, team: Faker::Company.name, address_1: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state, zipcode: Faker::Address.zip, country: Faker::Address.country, user_id: user.id)
end