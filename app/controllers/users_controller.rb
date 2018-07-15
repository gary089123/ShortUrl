class UsersController < ApplicationController

  before_action :auth, :only => :index

  def index
    @url = Url.new
    @url_list = current_user.urls
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

  def chartdata
    url = Url.find(params.fetch(:id))
    clicks = url.clicks
    time=[]
    clicks.each do |click|
      time << click.time
    end
    j_data = { origin:url.origin , redirect:url.redirect , count:clicks.length , time:time}
    render json: j_data, status: status

  end





  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
