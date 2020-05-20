require 'open-uri'

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


puts 'About to create 10 spaces'

garage = "https://images.unsplash.com/photo-1532884988337-3c5dca28cccc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80"
closet ="https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80"
white_closet = "https://images.unsplash.com/photo-1580792025119-484e27370138?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80"
house_garage = "https://images.unsplash.com/flagged/photo-1566838616793-29a4102a5b0e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80"
parking_lot = "https://images.unsplash.com/photo-1508465487720-54cef28cc719?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1566&q=80"
small_shed = "https://images.unsplash.com/photo-1507035159636-7a86eb324885?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1613&q=80"

users = User.all

adjectives = %w(Spacious Wide Small Big Medium Tiny Convenient Cool Superb Great Nice)

space = Space.new(
  title: "",
  address: Faker::Address.full_address,
  user: users.sample,
  description: ,
  price: (rand(1..10) * 5)
)
file = URI.open(images.sample)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!



puts 'Created 5 spaces.'


puts "About to create 15 bookings"

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
  message = "I'd like to store #{rand(2..4)} #{Faker::House.furniture}s."
  booking = Booking.new(
    start_date: start_date,
    end_date: end_date,
    space: space,
    user: user,
    message: message
  )

  # in case it's invalid due to date overlap
  create_booking unless booking.save
end

15.times do
  create_booking
end

puts "Created 15 bookings"
