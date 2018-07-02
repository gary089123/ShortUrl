require 'securerandom'
require 'rest-client'

class UrlsController < ApplicationController

  def index
    @url = Url.new
  end

  def create

    @url = Url.new(url_params)

    if @url.origin == ""
      flash[:error] = '請填入要轉址的url'
      redirect_to(:action => 'index')

    elsif ! (@url.origin =~ /^https?:\/\/(.*)/)

      flash[:error] = ' 錯誤url格式'
      redirect_to(:action => 'index')

    else

      begin
        RestClient.get @url.origin

        exist = Url.find_by origin: @url.origin

        if exist == nil

          if @url.redirect == nil
            @url.redirect = SecureRandom.hex(4)
          end

          if @url.save
            p @url.redirect
            flash[:success] = '成功產生網址 http://little.tw/' + @url.redirect
            redirect_to(:action => 'index')
          end


        else
          p exist
          flash[:notice] = '已存在短網址 http://little.tw/' + exist.redirect
          redirect_to(:action => 'index')

        end

      rescue SocketError
        flash[:error] = '您所輸入的 url 可能有些問題'
        redirect_to(:action => 'index')
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
