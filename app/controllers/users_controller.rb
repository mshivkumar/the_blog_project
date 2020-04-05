class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome the The Blog Project #{@user.username}"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    # @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Changes successfully updated'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = 'User and all its created articles have been successfully deleted'
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if (logged_in? && current_user != @user) and !current_user.admin?
      flash[:danger] = 'You can edit or update your own account'
      redirect_to root_path
    end
  end

  def require_admin_user
    if logged_in? && !current_user.admin?
      flash[:danger] = 'Only admins can perform this action'
      redirect_to root_path
    end
  end

end


