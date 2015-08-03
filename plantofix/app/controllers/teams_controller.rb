class TeamsController < ApplicationController

  # Save new team to database
  # POST /teams
  def create
    @team = Team.new(team_params)
    if @team.save
      @team.users << current_user
      @team.users << User.find_by_username(params["team"]["username"])
      @team.save
      redirect_to user_path(current_user), notice: 'Team was successfully created.'
    else
      redirect_to user_path(current_user)
    end
  end

  # PATCH/PUT /teams/1
  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to user_path(current_user), notice: 'Team was successfully updated.'
    else
      redirect_to user_path(current_user), alert: 'Team could not be updated.'
    end
  end

  # DELETE /teams/1
  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to user_path(current_user), notice: 'Team was successfully deleted.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :board_id)
    end
end
