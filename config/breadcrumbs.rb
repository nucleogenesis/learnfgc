crumb :root do
  link "Home", root_path
end

crumb :game do |game|
  link game.title, game
end

crumb :character do |character|
  link character.name, game_character_path(id: character.slug, game_id: character.game.slug)
  parent :game, character.game
end

crumb :frame_data do |character|
  link "Frame Data", frame_data_game_character_path(id: character.slug, game_id: character.game.slug)
  parent :character, character
end

crumb :combo do |character|
  link "Combos", combos_game_character_path(id: character.slug, game_id: character.game.slug)
  parent :character, character
end

crumb :article do |article|
  link article.title, article
  if article.character
    parent :character, article.character
  elsif article.game
    parent :game, article.game
  end
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
