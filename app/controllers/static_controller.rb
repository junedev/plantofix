class StaticController < ApplicationController
  before_action :authenticate, only: [:import_data]

  def home
    redirect_to boards_path if current_user
  end

  def import
  end

  def import_data
    if board = Board.import(github_params)
      redirect_to board_path(board)
    else
      redirect_to import_path, alert: "GitHub import not successful."
    end
  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def github_params
      params.require(:github).permit(:username,:repo,:boardname,:team_id)
    end
  end
