class UsersController < ApplicationController
before_action :current_user, only: [:edit, :update, :destroy]


  def index
    #@users = User.with_restricted_access
    @users = policy_scope(User)
    authorize @users
  end

  def show
  end

  def new
    @user = User.new
    authorize @user
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to text_path, notice: ("Você não tem permissão necessária")
    else
      render :new
  end
end

  def edit
    #authorize @user
  end

  def update
    if @user.update(user_params)
      redirect_to text_path
    else
      render :edit
    end
  end

  def destroy
  end

  def user_params
    password = params[:user][:password]

    if password.blank?
      params[:user].except!(:password)
    end

     params.require(:user).permit(:name, :email, :password, :role)
   end
end
