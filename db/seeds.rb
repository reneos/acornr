puts "Destroying all bookings"
Booking.destroy_all

puts "Destroying all spaces"
Space.destroy_all

puts "Destroying all users"
User.destroy_all

puts 'About to create 5 users'

5.times do
  user = User.new
  user.email = Faker::Internet.free_email
  user.password = 'password'
  user.password_confirmation = 'password'
  user.save!
end

puts 'Created 5 users'


puts 'About to create 20 spaces'

users = User.all

adjectives = %w(Spacious Wide Small Big Medium Tiny Convenient Cool Superb Great Nice)

20.times do
  Space.create!(
    title: "#{adjectives.sample} #{Faker::House.room}",
    address: Faker::Address.full_address,
    user: users.sample,
    description: Faker::Lorem.sentences(number: 8).join(' '),
  )
end


puts 'Created 20 spaces.'


puts "About to create 20 bookings"

def find_valid_user(host)
  # make sure a host is not renting their own space
  renter = User.all.sample
  renter == host ? find_valid_user(host) : renter
end

def create_booking
  start_date = Date.today + rand(1..10)
  end_date = start_date + rand(1..30)
  space = Space.all.sample
  user = find_valid_user(space.user)
  booking = Booking.new(
    start_date: start_date,
    end_date: end_date,
    space: space,
    user: user
  )

  # in case it's invalid due to date overlap
  create_booking unless booking.save
end

20.times do
  create_booking
end

puts "Created 20 bookings"
