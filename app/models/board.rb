class Board < ActiveRecord::Base
  belongs_to :team
  has_many :users, through: :team
  has_many :lists, dependent: :destroy
  validates :name, length: {in: 1..40}
  validates :team_id, numericality: {only_integer: true}

  def is_private_board?
    if self.team.users.count == 1
      true
    else
      false
    end
  end

  def self.import(github_params)
    position = 1
    username = github_params["username"]
    repo = github_params["repo"]
    boardname = github_params["boardname"]
    team_id = github_params["team_id"]

    # github = Github.new
    issues = Github::Client::Issues.new

    begin
      imported_data = issues.list(user: username, repo: repo, state: 'open')
    rescue
      return false
    else
      if imported_data.length > 0

        if Team.find(team_id)
          team = Team.find(team_id)
        else
          team = current_user.find_private_team
        end

        if boardname && boardname.length >= 1
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
        return board
      end
    end
  end

  private

  def self.check_for_color(object)
    if object.labels.length > 0
      return "#"+object["labels"][0]["color"]
    else
      return "white"
    end
  end

end
