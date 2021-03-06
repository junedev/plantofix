class TeamsController < ApplicationController
  before_action :authenticate
  # Save new team to database
  # POST /teams
  def create
    @team = Team.new(team_params)
    team_member = User.find_by_username(params["team"]["username"])
    if team_member && (team_member != current_user)
      if @team.save
        @team.users << current_user
        @team.users << team_member
        @team.save
        redirect_to user_path(current_user)
      else
        redirect_to user_path(current_user), alert: 'Team could not be created.'
      end
    else
      redirect_to user_path(current_user), alert: 'Team could not be created.'
    end
  end

  # PATCH/PUT /teams/1
  def update
    @team = Team.find(params[:id])
    redirect_to root_path unless @team.users.include?(current_user)
    if @team.update(team_params)
      redirect_to user_path(current_user)
    else
      redirect_to user_path(current_user), alert: 'Team could not be updated.'
    end
  end

  # DELETE /teams/1
  def destroy
    @team = Team.find(params[:id])
    redirect_to root_path unless @team.users.include?(current_user)
    if @team.boards.count == 0
      @team.destroy
    else
      @team.users.each do |user|
        delete_team_member(@team.id, user.id) unless user == current_user
      end
    end
    redirect_to user_path(current_user)
  end

  def team_member_destroy
    delete_team_member(params["team_id"],params["user_id"])
    redirect_to user_path(current_user)
  end

  def team_member_add
    team = Team.find(params["team_id"])
    user = User.find_by_username(user_params["username"])
    if user && !team.users.include?(user)
      team.users << user
    end
    redirect_to user_path(current_user)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :board_id)
    end

    def user_params
      params.require(:user).permit(:username)
    end

    def delete_team_member(team_id,user_id)
      user = User.find(user_id)
      team = Team.find(team_id)
      team.users.delete(user)
    end
  end
