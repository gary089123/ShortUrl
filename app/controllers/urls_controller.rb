require 'securerandom'
require 'rest-client'

class UrlsController < ApplicationController

  def index
    @url = Url.new
  end

  def create
    p "------"
    p request.referer

    @url = Url.new(url_params)
    if log_in?
      @url.user_id = session[:user_id]
    else
      @url.user_id = 0
    end

    if @url.origin == ""
      flash[:error] = '請填入要轉址的url'
      redirect_back(fallback_location: root_path)

    elsif ! (@url.origin =~ /^https?:\/\/(.*)/)

      flash[:error] = ' 錯誤url格式'
      redirect_back(fallback_location: root_path)

    else

      begin
        RestClient.get @url.origin
        exist = User.find(@url.user_id).urls.find_by origin: @url.origin
        #exist = Url.find_by origin: @url.origin

        if exist == nil

          if @url.redirect == nil
            rand_string = SecureRandom.hex(4)
            while Url.exists?(:redirect => rand_string)
              rand_string = SecureRandom.hex(4)
            end
            @url.redirect = rand_string
          end

          if @url.save
            p @url.redirect
            flash[:success] = '成功產生網址 http://little.tw/' + @url.redirect
            redirect_back(fallback_location: root_path)
          end


        else
          p exist
          flash[:notice] = '已存在短網址 http://little.tw/' + exist.redirect
          redirect_back(fallback_location: root_path)

        end

      rescue SocketError
        flash[:error] = '您所輸入的 url 可能有些問題'
        redirect_back(fallback_location: root_path)
      end





    end


  end


  def redirect
    redirect = params.fetch(:url)
    url = Url.find_by redirect: redirect
    if url != nil
      redirect_to url.origin
    else
      flash[:error] = '不存在的短網址'
      redirect_to(:action => 'index')
    end

  end


  private

  def url_params
    params.require(:url).permit(:origin, :redirect)
  end
end
