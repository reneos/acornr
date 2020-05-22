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

puts 'Created 6 users'


puts 'About to create 6 spaces'

garage = "https://buildingindonesia.co.id/wp-content/uploads/2019/07/3Y1A6296-a.jpg"
closet ="https://i.pinimg.com/originals/ff/ee/7c/ffee7c9ae389da06ca729043ee96fc78.jpg"
loft = "https://i.pinimg.com/originals/7f/c0/d2/7fc0d2174ce54a32eb83df38299ecbee.jpg"
living_room = "https://images.adsttc.com/media/images/573c/ef49/e58e/ceb3/1100/009a/large_jpg/frontofficetokyo_-_akasaka_-_bed_02.jpg?1463611197"
tatami = "https://uploads.greatideahub.com/uploads/2017/11/AdobeStock_113548908-1200x800.jpeg"
downstairs = "https://images.adsttc.com/media/images/530d/48f9/c07a/80ed/3b00/008a/large_jpg/02.jpg?1393379556"

users = User.all

space = Space.new(
  title: "Brand new garage",
  address: "1-chōme-7-5 Shimomeguro Meguro City, Tōkyō-to 153-0064",
  user: users.sample,
  description: "I have a spacious storage area in my garage that has some empty shelves available for short-term storage. I'm willing to store sealed cardboard boxes, but nothing perishable, please.",
  price: rand(3..10)*100 #USD->Yen
)
file = URI.open(garage)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!

space = Space.new(
  title: "Empty space in closet",
  address: "4 Chome-4-27, Meguro City, Tokyo 150-0042",
  user: users.sample,
  description: "A generously sized closet available for storing a variety of garments safely and securely (infrequently worn formalwear, bulky winter jackets, etc.) The closet is in my home and I'm available throughout the year.",
  price: rand(3..10)*100 #USD->Yen
)
file = URI.open(closet)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!

space = Space.new(
  title: "Graduate student with extra space",
  address: "2 Chome-1-28 Minato City, Tokyo 108-0073",
  user: users.sample,
  description: "I have a loft with some space, waiting to store your belongings. Boxes, (clean) bicycles, clothes, shoes other such items are acceptable. The area is very secure and my home is very well maintained, so your items will be safe with me.",
  price: rand(3..10)*100 #USD->Yen
)
file = URI.open(loft)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!

space = Space.new(
  title: "Minimalist salary man",
  address: "3-18-2 Yanaka Taito-ku Tokyo-to",
  user: users.sample,
  description: "I have a minimalist lifestyle, and I'm willing to lease out some of my living room space for storage for the summer months (now until September). You can fit a multiple large-sized boxes, etc. Let me know.",
  price: rand(3..10)*100 #USD->Yen
)
file = URI.open(living_room)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!

space = Space.new(
  title: "Tatami space",
  address: "3 Chome-55-10 Ikebukuro, Toshima City, Tokyo 171-0014",
  user: users.sample,
  description: "I'm not going to be using my tatami space in my new apartment. It's clean and cushioned so your things won't be easily damaged. I'm located close to the city center for easy drop off and pick up.",
  price: rand(3..10)*100 #USD->Yen
)
file = URI.open(tatami)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!

space = Space.new(
  title: "Family home storage",
  address: "3 Chome-5-6 Misakicho, Chiyoda City, Tokyo 101-0061",
  user: users.sample,
  description: "I live with my wife and 1 year old son. We have an empty room in our basement, so I'm leasing it for storage. Mostly anything is acceptable, as long as it will fit through the door (measures 5ft by 8ft). Long term storage is OK.",
  price: rand(3..10)*100 #USD->Yen
)
file = URI.open(downstairs)
space.photo.attach(io: file, filename: 'space.png', content_type: 'image/png')
space.save!

puts 'Created 6 spaces.'


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
