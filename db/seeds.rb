module Helper
  HOURS = [Time.parse('00:00:00'), Time.parse('23:59:00')]

  DATES = [Date.parse('01.01.2017'), Date.parse('31.12.2017')]

  class << self
    def random_record type, limit=1
      result = type.offset(rand(type.count))

      if limit == 1
        result.first
      else
        result.limit limit
      end
    end
  end
end

20.times.map do
  Category.create! name: Faker::Commerce.unique.department(2)
end unless Category.first

20.times.map do
  City.create! name: Faker::Address.unique.city
end unless City.first

unless User.first
  16.times.map do
    User.create! roles: :basic
  end

  8.times.map do
    User.create! \
      roles: [:basic, :registered],
      username: Faker::HarryPotter.unique.character.truncate(20),
      password: 'password'
  end
end

filename = 'tmp/image.jpeg'

100.times.map do
  File.open(filename, 'wb+') do |file|
    file.write open(Faker::LoremPixel.image('800x300')).read
  end

  place = Place.create! \
    city: Helper.random_record(City),
    category: Helper.random_record(Category),
    name: Faker::HarryPotter.location,
    description: Faker::Lorem.paragraph,
    address: Faker::Address.street_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    contacts: Faker::PhoneNumber.cell_phone,
    price: Faker::Commerce.price,
    photo: File.open(filename)

  File.unlink filename

  rand(20).times do
    Comment.create! \
      place: place,
      user: Helper.random_record(User.with_roles :registered),
      text: Faker::HarryPotter.quote.truncate(140, separator: ' ')
  end
end unless Place.first

10.times.map do
  Tag.create! \
    name: Faker::Commerce.color,
    places: Helper.random_record(Place, rand(25))
end unless Tag.first

User.all.map do |user|
  user.saved_places.push Helper.random_record(Place, rand(10))

  user.visited_places.push Helper.random_record(Place, rand(10))
end

20.times do
  Wish.create! text: Faker::RickAndMorty.quote
end unless Wish.first
