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
  email: "nucleogenesis@learnfgc.com",
  roles: "Street Fighter V"
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
  game_id =  Proc.new { |n| (n > 0) ? n : nil }.call(Random.rand(0..2))
  if game_id
    character_id = Proc.new { |n| (n > 0) ? (Random.rand(Game.find(game_id).characters.length) + 1) : nil }.call(Random.rand(-5..6))
  end

  article = FactoryGirl.create(
    :random_article,
    game_id: game_id,
    character_id: character_id,
    user_id: 1
  )

  (Random.rand(20)).times do
    question = FactoryGirl.create(:question, user_id: 1, article_id: article.id)

    (Random.rand(10)).times do
      FactoryGirl.create(:question_comment, question_id: question.id, user_id: 1)
    end
  end
end

Question.all.each do |q|
  return if Random.rand(10) > 7 || q.question_comments.length < 1
    
  c = q.question_comments.first
  c.accepted = true
  c.save
end
