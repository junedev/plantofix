class StaticController < ApplicationController

  def home
    redirect_to boards_path if current_user
  end

  def import
  end

  def import_data
    position = 1
    username = params["github"]["username"]
    repo = params["github"]["repo"]
    github = Github.new
    issues = Github::Client::Issues.new
    team = Team.find_private_team(current_user)
    board = team.boards.create!(name:repo)
    list = board.lists.create!(name:"ToDo")
    board.lists.create!(name:"In progress")
    board.lists.create!(name:"Done")
    imported_data = issues.list(user: username, repo: repo, state: 'open')
    if imported_data.length > 0
      imported_data.each do |issue|
        list.tasks.create!(name: issue["title"], color: "white", position: position += 1)
      end
      redirect_to board_path(board)
    else
      redirect_to "/import", alert: "Import not successful."
    end
  end

end
