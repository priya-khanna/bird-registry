# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

birds_data = []
(1..50).each do |i|
  continents = []
  rand(1..7).times { |x| continents << "Cont#{x}" }
  birds_data << {
    name: "Bird#{i}", family: "Family#{i}", continents: continents, added: rand(Time.zone.parse('1-1-2016')..Time.now).strftime("%Y-%m-%d"), visible: %w(true false true).shuffle.first
  }
end

Bird.create(birds_data)
puts "Done!"


