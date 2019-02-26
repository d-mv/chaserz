# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

print '~ destroying'.red
Race.destroy_all
print '.'.red
Kit.destroy_all
print '.'.red
User.destroy_all
print '.'.red
puts 'done'.blue

print 'creating special'.green
User.create!(email: 'admin@lewagon.com',first_name: 'Dmitry',last_name: 'lewagon', nickname: '👨‍💻dima', profile_type: 'junior', occupation: 'software engineer', photo:'https://picsum.photos/150/?random', password: '123123', points: 50000, age: 30, nationality: 'israel')
print '.admin.'.green
User.create!(email: 'user@lewagon.com',first_name: 'Roni',last_name: 'lewagon', nickname: 'Ronibaba', profile_type: 'junior', occupation: 'software engineer', photo:'https://picsum.photos/150/?random', password: '123123', points: 80000, age: 20, nationality: 'israel')
print '.user.'.green
puts 'done'.blue

print 'creating users'.green
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
puts 'done'.blue

print 'creating kits'.green
User.all.each do |usr|
print '.'.green
  rand(1..3).times do |el|
    Kit.create!(
    user_id: usr.id,
    name: Faker::FunnyName.name,
    description: Faker::Vehicle.manufacture,
    photo: 'https://picsum.photos/200/300/?random',
    )
  end
end
puts 'done'.blue

print 'creating races'.green
User.all.each do |usr|
  print '.'.green
  start_value = rand(2..30)
  Race.create!(
    user_id: usr.id,
    title: Faker::Lorem.sentence(3),
    start_date: Faker::Date.forward(start_value),
    category: Faker::Lorem.sentence(3),)
end
puts 'done'.blue

print 'assigning participants'.green
Race.all.each do |rce|
  print '.'.green
  rand(5..10).times do |part|
   Participant.create!(
    race_id: rce.id,
    user_id: User.all.sample.id,
    duration: rand(1000..60000),
    points: rand(0..100),
    status: %w[finished dropped missed].sample,
   )
 end
end
puts 'done'.blue

print 'creating checkpoints'.green
Race.all.each do |rce|
  print '.'.green
  Checkpoint.create!(
  race_id: rce.id,
  lon: 34.769618,
  lat: 32.084481,
  )
  Checkpoint.create!(
  race_id: rce.id,
  lon: 34.768127,
  lat: 32.082198,
  )
  Checkpoint.create!(
  race_id: rce.id,
  lon: 34.766925,
  lat: 32.078598,
  )
  Checkpoint.create!(
  race_id: rce.id,
  lon: 34.766925,
  lat: 32.078598,
  )
  end
puts 'done'.blue
puts ''
puts 'All done!'.green
