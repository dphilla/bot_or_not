class UsersController < ApplicationController
  include Verify
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    require 'pry'; binding.pry
    if Verify.is_valid_phone_number?(user_params['phonenumber'])
      @user = User.new(user_params)
      @user.save
      redirect_to @user, notice: 'You have a valid phone number!'
    else
      redirect_to new_user_path, notice: 'Please enter a valid phone number'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if Verify.valid_confirmation_code?(params['code'], params['id'])
      @user = User.update(verified: true)
      redirect_to @user, notice: 'you have been verified!'
    else
      redirect_to new_user_path, notice: 'invalid or expired token'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :phonenumber, :code)
    end
end
