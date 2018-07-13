class UsersController < ApplicationController

  before_action :auth, :only => :index

  def index
    @url = Url.new
    @url_list = Url.all
  end



  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      p "success create user"
      redirect_to '/user/login'
    else
      render 'new'
    end
  end





  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
