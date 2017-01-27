class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :create]
  wrap_parameters :user, include: [:email, :name, :password, :password_confirmation, :id, :password_digest]

  # GET /users
  def index
    @users = User.all
    render json: @users
    headers['Access-Control-Allow-Origin'] = "*"
  end

  # GET /users/1
  def show
    render json: @user
    headers['Access-Control-Allow-Origin'] = "*"
  end

  # POST /users
  def create
    user = User.new(user_params)
    headers['Access-Control-Allow-Origin'] = "*"
    if user.save
      render json: user, status: :created, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      headers['Access-Control-Allow-Origin'] = "*"
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_User
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :id, :password_digest)
    end
end



