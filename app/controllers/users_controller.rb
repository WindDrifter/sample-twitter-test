class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :follow_user, :unfollow_user]
  before_action :required_login, only: [:show, :edit, :update, :destroy, :follow_user, :unfollow_user]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @is_following = false
    if @current_user
      @is_following =   @user.is_following(@current_user)
    end
    @posts = Post.where(user_id: @user.id)
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
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def follow_user
    following = Following.find_by(following:@user.id, user_id: @current_user.id)
    if following
      notice = "Already following user"
    else
      following = Following.new
      following.user_id = @current_user.id
      following.following = @user.id
      following.save!
      notice = "You are following user: " + @user.username
    end
    respond_to do |format|
      format.html { redirect_to @user, notice: notice }
      format.json { render :show, status: :ok, location: @user }
    end
  end
  def unfollow_user
    following = Following.find_by(following:@user.id, user_id: @current_user.id)
    notice = 'You are not following user'
    if following
      following.destroy
      notice = 'You have successfully unfollow user'
    end
    respond_to do |format|
      format.html { redirect_to @user, notice: notice }
      format.json { render :show, status: :ok, location: @user }
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
      params.require(:user).permit(:username, :first_name, :last_name, :email, :password)
    end
end
