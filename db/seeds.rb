# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# binding.pry

print '~ destroying'.red
Race.destroy_all
print '.'.red
Kit.destroy_all
print '.'.red
User.destroy_all
print '.'.red
puts 'done'.blue

url = "https://uifaces.co/api?random&limit=8"
people = JSON.parse(open(url,"X-API-KEY" => ENV['XAPIKEY']).read)
# people.map { |person| person['photo']="https://#{person['photo'].split('://')[1]}" }

print 'creating special users'.green
User.create!(email: 'admin@lewagon.com',first_name: 'Dmitry',last_name: 'Melnikov', nickname: '👨‍💻dima', profile_type: 'Junior Racer', occupation: 'Software engineer', photo:'https://res.cloudinary.com/diciu4xpu/image/upload/v1551801252/chaserz/avatars/dmitry.jpg', password: '123123', points: 100, age: 39, nationality: 'Israel')
print '.admin.'.green

User.create!(email: 'user@lewagon.com',first_name: 'Roni',last_name: 'Talvi', nickname: 'Roni V', profile_type: 'Junior Racer', occupation: 'Software engineer', photo:'https://res.cloudinary.com/diciu4xpu/image/upload/v1551801252/chaserz/avatars/rony.jpg', password: '123123', points: 200, age: 20, nationality: 'Israel')
print '.user.'.green

User.create!(email: 'ben@lewagon.com',first_name: 'Benjamin',last_name: 'Aronov', nickname: 'Ben', profile_type: 'Star', occupation: 'Software engineer', photo:'https://res.cloudinary.com/diciu4xpu/image/upload/v1551801252/chaserz/avatars/ben.jpg', password: '123123', points: 1200, age: 20, nationality: 'USA')
print '.user.'.green
puts 'done'.blue

photo_array = [
'https://randomuser.me/api/portraits/women/63.jpg',
'https://randomuser.me/api/portraits/men/40.jpg',
'https://randomuser.me/api/portraits/men/43.jpg',
'https://randomuser.me/api/portraits/women/95.jpg',
'https://randomuser.me/api/portraits/women/64.jpg',
'https://randomuser.me/api/portraits/men/41.jpg',
'https://randomuser.me/api/portraits/men/42.jpg',
'https://randomuser.me/api/portraits/women/96.jpg']

profile_array = ['Junior Racer', 'Experienced', 'Pro']

print 'creating users'.green
i = 0
8.times do
  print '.'.green

  user = User.new(
    email: people[i]["email"],
    first_name:   people[i]["name"],
    last_name:   Faker::Name.last_name,
    nickname: Faker::Movies::StarWars.character,
    profile_type: profile_array.sample,
    age: rand(13..40),
    occupation:  people[i]["position"],
    points: rand(0..100),
    nationality: 'Israel',
    photo:  photo_array[i],
    password: "123123"
  )
  user.save!
  i += 1
end
puts 'done'.blue

print 'creating kits'.green
User.all.each do |usr|
print '.'.green
    Kit.create!(
    user_id: usr.id,
    name: Faker::FunnyName.name,
    description: Faker::Vehicle.manufacture,
    photo: 'https://res.cloudinary.com/diciu4xpu/image/upload/v1551801924/chaserz/kits/scooter_4.jpg',
    )
end
User.find(1).kits[0].update(photo: 'https://res.cloudinary.com/diciu4xpu/image/upload/v1551800870/chaserz/kits/scooter_1.jpg')
print '.'.green
User.find(2).kits[0].update(photo: 'https://res.cloudinary.com/diciu4xpu/image/upload/v1551800871/chaserz/kits/scooter_2.jpg')
print '.'.green
Kit.create!(user_id: 2,
    name: Faker::FunnyName.name,
    description: 'Cup holder.Needed one badly.',
    photo: 'https://res.cloudinary.com/diciu4xpu/image/upload/v1551800870/chaserz/kits/cup_holder.jpg',)
    print '.'.green
    Kit.create!(user_id: 2,
    name: Faker::FunnyName.name,
    description: 'Basket for stuff',
    photo: 'https://res.cloudinary.com/diciu4xpu/image/upload/v1551800870/chaserz/kits/basket.jpg',)
print '.'.green
User.find(3).kits[0].update(photo: 'https://res.cloudinary.com/diciu4xpu/image/upload/v1551800871/chaserz/kits/scooter_3.jpg')
print '.'.green
Kit.create!(user_id: 3,
    name: Faker::FunnyName.name,
    description: 'Speed meter',
    photo: 'https://res.cloudinary.com/diciu4xpu/image/upload/v1551800870/chaserz/kits/meter.jpg',)
    print '.'.green
Kit.create!(user_id: 3,
    name: Faker::FunnyName.name,
    description: 'Best phone holder',
    photo: 'https://res.cloudinary.com/diciu4xpu/image/upload/v1551800871/chaserz/kits/phone_holder.jpg',)
    print '.'.green
    Kit.create!(user_id: 3,
    name: Faker::FunnyName.name,
    description: 'Just in case, I\'ve got bag' ,
    photo: 'https://res.cloudinary.com/diciu4xpu/image/upload/v1551800870/chaserz/kits/bag.jpg',)
puts 'done'.blue

print 'creating races'.green
User.all.each do |usr|
  print '.'.green
  start_value = rand(2..30)
  Race.create!(
    user_id: usr.id,
    title: Faker::Lorem.sentence(2),
    start_date: Faker::Date.forward(start_value),
    category: 'Applied',)
end
puts 'done'.blue

print 'assigning participants'.green
Race.all.each do |rce|
  print '.'.green
  qty = rand(2..5)
  users = User.all.sample(qty)
  counter = 0
  qty.times do |part|
   Participant.create!(
    race_id: rce.id,
    user_id: users[counter].id,
    duration: 0,
    points: 0,
    status: %w[applied dropped missed].sample,
   )
   counter += 1
 end
end
puts 'done'.blue

print 'creating checkpoints'.green
Race.all.each do |rce|
  print '.'.green
  Checkpoint.create!(
  position: 1,
  race_id: rce.id,
  longitude: 34.766921,
  latitude: 32.078592,
  )
  Checkpoint.create!(
  position: 2,
  race_id: rce.id,
  longitude: 34.767746,
  latitude:  32.082028,
  )
  Checkpoint.create!(
  position: 3,
  race_id: rce.id,
  longitude: 34.766858,
  latitude:  32.079319,
  )
  Checkpoint.create!(
  position: 4,
  race_id: rce.id,
  longitude:  34.766118,
  latitude:  32.078698,
  )
  Checkpoint.create!(
  position: 5,
  race_id: rce.id,
  longitude: 34.765544,
  latitude:  32.075341,
  )
  Checkpoint.create!(
  position: 6,
  race_id: rce.id,
  longitude: 34.762714,
  latitude:  32.067418,
  )
  end
puts 'done'.blue
puts ''
puts 'All done!'.green
