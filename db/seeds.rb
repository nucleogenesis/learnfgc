# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |n|
  FactoryGirl.create(:article, title: "Article With A Title ##{n}")
end

Game.create(abbr: "SFV", title: "Street Fighter V")

["Ryu", "Chun-Li", "Nash", "M. Bison", "Cammy", "Birdie", "Ken", "Necalli", "Vega", "R. Mika", "Rashid", "Karin", "Zangief", "Laura", "Dhalsim", "F.A.N.G."].each do |name|
  Character.create(name: name, history: Faker::Lorem.paragraph(2), game_id: 1)
end
