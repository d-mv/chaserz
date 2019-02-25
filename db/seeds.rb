# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

print '~ destroying...'.red



Race.destroy_all
Kit.destroy_all
User.destroy_all


puts 'done'.blue

puts 'creating us'
User.create!(email: 'admin@lewagon.com',first_name: 'dmitry',last_name: 'lewagon', nickname: 'dmitrybaba', profile_type: 'junior', occupation: 'software engineer', photo:'https://picsum.photos/150/?random', password: '123123', points: 0, age: 30, nationality: 'israel')
User.create!(email: 'user@lewagon.com',first_name: 'roni',last_name: 'lewagon', nickname: 'ronibaba', profile_type: 'junior', occupation: 'software engineer', photo:'https://picsum.photos/150/?random', password: '123123', points: 0, age: 20, nationality: 'israel')


puts 'users'

10.times do
  print '.'.green
  user = User.new(
    email:    Faker::Internet.email,
    first_name:   Faker::Name.name,
    last_name:   Faker::Name.last_name,
    nickname: Faker::Movies::StarWars.character,
    profile_type: 'junior',
    age: rand(13..40),
    occupation: Faker::Job.title,
    points: 0,
    nationality: 'israel',
    photo: 'https://picsum.photos/150/?random',

    password: "123123"
  )
  user.save!
end
puts 'users created'.green
puts 'creating kits'.blue

User.all.each do |usr|
puts '.'.blue
  kit = Kit.create!(
    user_id: usr.id,
    name: Faker::FunnyName.name,
    description: Faker::Vehicle.manufacture,
    photo: 'https://picsum.photos/200/300/?random',
    )
end

puts 'created kits'.blue


puts 'races creating'.blue
User.all.each do |usr|
  puts '.'.blue
  start_value = rand(2..30)
  race = Race.create!(
    user_id: usr.id,
    title: Faker::Lorem.sentence(3),
    start_date: Faker::Date.forward(start_value),
    category: Faker::Lorem.sentence(3),)
end

puts 'races created'.green


puts 'participants creating'.red

Race.all.each do |rce|
   puts '.'.red
  rand(5..10).times do |part|
   participant = Participant.create!(
    race_id: rce.id,
    user_id: User.all.sample.id,
    duration: rand(1000..60000),
     points: rand(0..100),
     status: %w[finished dropped missed].sample,
   )
 end
end

puts 'participants created'.red


puts 'checkpoints creating'.red

Race.all.each do |rce|
  puts '.'.red

 first = Checkpoint.create(
  race_id: rce.id,
  lon: 34.769618,
  lat: 32.084481,
  )
 second = Checkpoint.create(
  race_id: rce.id,
  lon: 34.768127,
  lat: 32.082198,
  )
  third = Checkpoint.create(
  race_id: rce.id,
  lon: 34.766925,
  lat: 32.078598,
  )
  fourth = Checkpoint.create(
  race_id: rce.id,
  lon: 34.766925,
  lat: 32.078598,
  )

  end
puts 'checkpoints created'.red
