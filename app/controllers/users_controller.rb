class UsersController < ApplicationController
  # 認可の技：　editか updateが呼ばれたときに signed_in_userを実行しよう
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  # 正しいユーザか
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Success
      flash[:success] = "Profile was successfully updated"
      redirect_to @user
    else
      # Failed
      render 'edit'
    end
  end

  def create
    #@user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      #Success
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # /users/:id
    else
      # Failed
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before actions

    def signed_in_user
      # noticeはflashみたいなもの
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
      #redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user

      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
      #redirect_to signin_url unless @user == current_user
    end

    def admin_user
      #redirect_to signin_url unless current_user.admin?
      redirect_to(root_path) unless current_user.admin?
    end
end
