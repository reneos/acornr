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
