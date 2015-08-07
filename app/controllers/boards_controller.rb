class BoardsController < ApplicationController

  # Board overview page
  # GET /boards
  def index
  end

  # Board show page
  # GET /boards/1
  def show
    @board = Board.find(params[:id])
    redirect_to root_path unless @board.users.include?(current_user)
    redirect_to root_path unless logged_in?
  end

  # Save new board to database
  # POST /boards
  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to boards_path
    else
      redirect_to boards_path, alert: 'Board could not be created.'
    end
  end

  # PATCH/PUT /boards/1
  def update
    @board = Board.find(params[:id])
    redirect_to root_path unless @board.users.include?(current_user)
    if @board.update(board_params)
      redirect_to board_path
    else
      redirect_to board_path, alert: 'Board could not be updated.'
    end
  end

  # DELETE /boards/1
  def destroy
    @board = Board.find(params[:id])
    redirect_to root_path unless @board.users.include?(current_user)
    @board.destroy
    redirect_to boards_path
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:name, :team_id)
    end
end
