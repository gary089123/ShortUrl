module SessionsHelper

  def log_in (user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def log_in?
    !session[:user_id].nil?
  end

  def current_user
    if @current_user.nil?
      @current_user = User.find(session[:user_id])
    else
      @current_user
    end
  end

  def auth
    if !log_in?
      redirect_to '/user/login'
    end

  end
end
