class ListsController < ApplicationController
  before_action :authenticate
  # Save new list to database
  # POST /lists
  def create
    @list = List.new(list_params)
     if @list.save
      redirect_to "/boards/#{get_current_board["id"]}"
    else
      redirect_to "/boards/#{get_current_board["id"]}", alert: 'List could not be created.'
    end
  end

  # PATCH/PUT /lists/1
  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to "/boards/#{get_current_board["id"]}"
    else
      redirect_to "/boards/#{get_current_board["id"]}", alert: 'List could not be updated.'
    end
  end

  # DELETE /lists/1
  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to "/boards/#{get_current_board["id"]}"
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:name, :board_id)
    end
end
