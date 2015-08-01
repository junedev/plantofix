class BoardsController < ApplicationController

  # Board show page
  # GET /boards/1
  def show
    @board = Board.find(params[:id])
    redirect_to root_path unless logged_in?
  end

  #GET /boards/new
  # def new
  #   @board = Board.new
  # end

  # GET /boards/1/edit
  # def edit
  #   @board = Board.find(params[:id])
  #   redirect_to root_path unless authenticate_user(@user)
  # end

  # Save new board to database
  # POST /boards
  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to board_path, notice: 'Board was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /boards/1
  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path, notice: 'Board was successfully updated.'
    else
      redirect_to board_path, alert: 'Board could not be updated.'
    end
  end

  # DELETE /boards/1
  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path, notice: 'Board was successfully deleted.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def board_params
      params.require(:board).permit(:name, :team_id)
    end
end
