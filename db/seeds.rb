print '~ destroying'.red
Race.destroy_all
print '.'.red
Kit.destroy_all
print '.'.red
User.destroy_all
print '.'.red
puts 'done'.blue

url = "https://uifaces.co/api?random&limit=2"
people = JSON.parse(open(url,"X-API-KEY" => ENV['XAPIKEY']).read)
# people.map { |person| person['photo']="https://#{person['photo'].split('://')[1]}" }

print 'creating users'.green
User.create!(email: 'admin@lewagon.com',first_name: 'Dmitry',last_name: 'Melnikov', nickname: '👨‍💻dima', profile_type: 'Junior Racer', occupation: 'Software engineer', photo:'https://res.cloudinary.com/diciu4xpu/image/upload/v1551801252/chaserz/avatars/dmitry.jpg', password: '123123', points: 100, age: 39, nationality: 'Israel')
print '.admin.'.green

User.create!(email: 'user@lewagon.com',first_name: 'Roni',last_name: 'Talvi', nickname: 'Roni V', profile_type: 'Junior Racer', occupation: 'Software engineer', photo:'https://res.cloudinary.com/diciu4xpu/image/upload/v1551801252/chaserz/avatars/rony.jpg', password: '123123', points: 98, age: 20, nationality: 'Israel')
print '.user.'.green

User.create!(email: 'ben@lewagon.com',first_name: 'Benjamin',last_name: 'Aronov', nickname: 'Ben', profile_type: 'Star', occupation: 'Software engineer', photo:'https://res.cloudinary.com/diciu4xpu/image/upload/v1551801252/chaserz/avatars/ben.jpg', password: '123123', points: 205, age: 20, nationality: 'USA')
print '.user.'.green

User.create!(email: 'david@lewagon.com',first_name: 'David',last_name: 'Metta', nickname: 'Davo', profile_type: 'Star', occupation: 'Software engineer', photo:'https://res.cloudinary.com/diciu4xpu/image/upload/v1551887892/chaserz/avatars/david.jpg', password: '123123', points: 400, age: 20, nationality: 'USA')
print '.user.'.green

profile_array = ['Junior Racer', 'Experienced', 'Pro']

User.create!(
    email: 'user_2@lewagon.com',
    first_name:  'Misty',
    last_name: 'Miles',
    nickname: 'Mistery',
    profile_type: profile_array.sample,
    age: rand(13..40),
    occupation:  'Enjoying life',
    points: rand(0..100),
    nationality: 'Israel',
    photo:  'https://randomuser.me/api/portraits/women/63.jpg',
    password: "123123"
  )
  print '.'.green
print '.'.green
  User.create!(
    email: 'user_3@lewagon.com',
    first_name:  'Randy',
    last_name: 'Powel',
    nickname: 'Random Wonder',
    profile_type: profile_array.sample,
    age: rand(13..40),
    occupation:  'Student',
    points: rand(0..100),
    nationality: 'Israel',
    photo:  'https://randomuser.me/api/portraits/men/40.jpg',
    password: "123123"
  )
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
start_value = rand(2..30)
Race.create!(
    user_id: 1,
    title: 'Dizengoff-Azerieli Masters',
    start_date: Faker::Date.forward(start_value),
    category: '',)
print '.'.green
Race.create!(
    user_id: 2,
    title: 'Promenade Show-off',
    start_date: '2019-03-07',
    category: '',)
print '.'.green
Race.create!(
    user_id: 3,
    title: 'Yafo Jam',
    start_date: Faker::Date.forward(start_value),
    category: '',)
print '.'.green
Race.create!(
    user_id: 4,
    title: 'Bograshov Challenge',
    start_date: Faker::Date.forward(start_value),
    category: '',)
print '.'.green
Race.create!(
    user_id: 5,
    title: 'King George Slam',
    start_date: Faker::Date.forward(start_value),
    category: '',)
print '.'.green
puts 'done'.blue



print 'assigning participants'.green
  Participant.create!(
    race_id: 1,
    user_id: User.find(1).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
  Participant.create!(
    race_id: 1,
    user_id: User.find(2).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 1,
    user_id: User.find(4).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 2,
    user_id: User.find(2).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 2,
    user_id: User.find(3).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 2,
    user_id: User.find(4).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 2,
    user_id: User.find(5).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 3,
    user_id: User.find(3).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 3,
    user_id: User.find(6).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 4,
    user_id: User.find(6).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 4,
    user_id: User.find(1).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 4,
    user_id: User.find(2).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 4,
    user_id: User.find(3).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 4,
    user_id: User.find(4).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 5,
    user_id: User.find(6).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 5,
    user_id: User.find(5).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 5,
    user_id: User.find(4).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
Participant.create!(
    race_id: 5,
    user_id: User.find(3).id,
    duration: 0,
    points: 0,
    status: 'finished',
  )
print '.'.green
puts 'done'.blue

print 'creating checkpoints'.green
Race.all.each do |rce|
  print '.'.green
Checkpoint.create!(race_id: rce.id, position: 1, latitude: 32.076356, longitude: 34.765882, location: "Beach Front")
Checkpoint.create!(race_id: rce.id,
position: 2, latitude: 32.077601,  longitude: 34.766345, location: "Mike's Place")
Checkpoint.create!(race_id: rce.id,
position: 3, latitude: 32.078823, longitude: 34.766782, location: "London Garden")
end
puts 'done'.blue
puts ''
puts 'All done!'.green
