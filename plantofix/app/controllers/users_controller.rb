class UsersController < ApplicationController

  # Profile page
  # GET /users/1
  def show
    @user = User.find(params[:id])
    redirect_to root_path unless authenticate_user(@user)
  end

  # Sign-up page
  # GET /users/new
  def new
    @user = User.new
  end

  # Edit profile
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    redirect_to root_path unless authenticate_user(@user)
  end

  # Save new user from to database
  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # Save edited profile to database
  # PATCH/PUT /users/1
  def update
    @user = User.new(user_params)
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.new(user_params)
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :avatar_url, :email, :password, :password_confirmation)
    end
end
