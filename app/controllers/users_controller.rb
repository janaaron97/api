class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :create]
  wrap_parameters :user, include: [:email, :name, :password, :password_confirmation, :id, :password_digest]
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # GET /users
  def index
    @users = User.all
    render json: @users
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


  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

# If this is a preflight OPTIONS request, then short-circuit the
# request, return only the necessary headers and return an empty
# text/plain.

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_User
      @user = User.find(params[:id])
    end

    def add_header
      headers['Access-Control-Allow-Origin'] = "*"
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :id, :password_digest)
    end
end



