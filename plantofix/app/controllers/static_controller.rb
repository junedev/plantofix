class StaticController < ApplicationController

  def home
    redirect_to boards_path if current_user
  end

end
