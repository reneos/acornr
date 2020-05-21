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


puts 'About to create 5 spaces'

garage = "https://images.unsplash.com/photo-1532884988337-3c5dca28cccc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80"
closet ="https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80"
white_closet = "https://images.unsplash.com/photo-1580792025119-484e27370138?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80"
house_garage = "https://images.unsplash.com/flagged/photo-1566838616793-29a4102a5b0e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80"
parking_lot = "https://images.unsplash.com/photo-1508465487720-54cef28cc719?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1566&q=80"
small_shed = "https://images.unsplash.com/photo-1507035159636-7a86eb324885?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1613&q=80"

users = User.all

space = Space.new(
  title: "Shelving in Stock Room",
  address: "Tokyo, Japan",
  user: users.sample,
  description: "I have a spacious storage room at the back of my shop that has some empty shelves available for short-term storage. I'm willing to store sealed cardboard boxes, but nothing perishable, please.",
  price: rand(3..10)
)
file = URI.open(garage)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!

space = Space.new(
  title: "Convenient Clothing Storage",
  address: "Osaka, Japan",
  user: users.sample,
  description: "A generously sized walk-in closet area available for storing a variety of garments safely and securely (infrequently worn formalwear, bulky winter jackets, etc.) The closet is in my home and I'm available throughout the year.",
  price: rand(3..10)
)
file = URI.open(closet)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!

space = Space.new(
  title: "Immaculate Closet",
  address: "Kyoto, Japan",
  user: users.sample,
  description: "I have a guest bedroom with a completely empty closet, waiting to store your belongings. Boxes, (clean) bicycles, clothes, shoes other such items are acceptable. The area is very secure and my home is very well maintained, so your items will be safe with me.",
  price: rand(3..10)
)
file = URI.open(white_closet)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!

space = Space.new(
  title: "Summer Storage Garage",
  address: "Kobe, Japan",
  user: users.sample,
  description: "I have a large garage that I'm willing to lease out for storage for the summer months (now until September). You can fit a medium-sized car or other boxes, etc. Let me know.",
  price: rand(3..10)
)
file = URI.open(house_garage)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!

space = Space.new(
  title: "Parking space",
  address: "Kumamoto, Japan",
  user: users.sample,
  description: "I'm not going to be using my parking space between now and August 31st. It's close to city center and the entrance ot the parking lot is monitored via camera 24/7 so it's very secure.",
  price: rand(3..10)
)
file = URI.open(parking_lot)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!

space = Space.new(
  title: "Shed",
  address: "Hakone, Japan",
  user: users.sample,
  description: "A shed in my backyard has been sitting empty for some months, so I'm leasing it for storage. Mostly anything is acceptable, as long as it will fit through the door (measures 5ft by 8ft). Long term storage is OK.",
  price: rand(3..10)
)
file = URI.open(small_shed)
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
