class StaticController < ApplicationController

  def home
    redirect_to boards_path if current_user
  end

  def import
  end

  def import_data
    Board.import(params["github"]["username"], params["github"]["repo"])
    redirect_to boards_path
  end

end
