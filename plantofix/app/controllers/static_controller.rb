class StaticController < ApplicationController

  def home
    redirect_to boards_path if current_user
  end

  def import
  end

  def import_data
    position = 1
    username = github_params["username"]
    repo = github_params["repo"]
    boardname = github_params["boardname"]
    team = Team.find_private_team(current_user)

    github = Github.new
    issues = Github::Client::Issues.new

    begin
      imported_data = issues.list(user: username, repo: repo, state: 'open')
    rescue
      redirect_to "/import", alert: "Import not successful."
    else
      if imported_data.length > 0
        if boardname
          board = team.boards.create!(name:boardname)
        else
          board = team.boards.create!(name:repo)
        end
        list = board.lists.create!(name:"ToDo")
        board.lists.create!(name:"In progress")
        board.lists.create!(name:"Done")

        imported_data.each do |issue|
          list.tasks.create!(name: issue["title"], color: "white", position: position += 1, 
            description: issue["body"], color: check_for_color(issue))
        end
        redirect_to board_path(board)
      else
        redirect_to "/import", alert: "Import not successful."
      end
    end
  end


  private

  def check_for_color(object)
    if object.labels.length > 0
      return "#"+object["labels"][0]["color"]
    else
      return "white"
    end
  end
    # Never trust parameters from the scary internet, only allow the white list through.
    def github_params
      params.require(:github).permit(:username,:repo,:boardname)
    end
  end
