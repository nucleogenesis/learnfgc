# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
  username: "nucleogenesis", 
  password: "password", 
  email: "nucleogenesis@learnfgc.com"
)

Game.create(abbr: "SFV", title: "Street Fighter V")     # STREET FIGHTER V - ID: 1
Game.create(abbr: "RT", title: "Rising Thunder")        # RISING THUNDER - ID: 2

["Ryu", "Chun-Li", "Nash", "M. Bison", "Cammy", "Birdie", "Ken", "Necalli", "Vega", "R. Mika", "Rashid", "Karin", "Zangief", "Laura", "Dhalsim", "F.A.N.G."].each do |name|
  Character.create(name: name, history: Faker::Lorem.paragraph(2), game_id: 1)
end

["Edge", "Talos", "Chel", "Crow", "Vlad", "Dauntless"].each do |name|
  Character.create(name: name, history: Faker::Lorem.paragraph(2), game_id: 2)
end

100.times do
  FactoryGirl.create(
    :random_article,
    game_id: Proc.new { |n| (n > 0) ? n : nil }.call(Random.rand(0..2)),
    character_id: Proc.new { |n| (n > 0) ? n : nil }.call(Random.rand(-5..6)),
    user_id: 1
  )
end
