class UsersController < ApplicationController

  # Profile page
  # GET /users/1
  def show
    @user = User.find(params[:id])
    @team = Team.new
    redirect_to root_path unless authenticate_user(@user)
  end

  # Sign-up page
  # GET /users/new
  def new
    @user = User.new
  end

  # Save new user from to database
  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      team = @user.teams.create!(name: "Private board")
      redirect_to @user
    else
      render :new
    end
  end

  # Save edited profile to database
  # PATCH/PUT /users/1
  def update
    @user = User.find(params[:id])
    redirect_to root_path unless authenticate_user(@user)
    if (@user && @user.authenticate(params[:user][:password])) && @user.update(user_params) 
      redirect_to @user
    else
      redirect_to @user, alert: 'Account details could not be changed.'
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    redirect_to root_path unless authenticate_user(@user)
    private_team = current_user.find_private_team
    private_team.boards.destroy_all
    private_team.destroy
    session[:user_id] = nil
    @user.delete
    redirect_to root_path
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :avatar_url, :email, :password, :password_confirmation)
    end
  end
