require 'securerandom'
require 'net/http'

class UrlController < ApplicationController

  def index
    @url = Url.new
  end

  def create

    @url = Url.new(url_params)
    if @url.origin == ""
      flash[:error] = '請填入要轉址的url'
      redirect_to(:action => 'index')
    else


      exist = Url.find_by origin: @url.origin

      if exist == nil
        
        if @url.redirect == ""
          @url.redirect = SecureRandom.hex(4)
        end

        if @url.save
            p @url.redirect
            flash[:success] = '成功產生網址 https://little.tw/' + @url.redirect
            redirect_to(:action => 'index')
        end


      else
        p exist
        flash[:notice] = '已存在短網址 https://little.tw/' + exist.redirect
        redirect_to(:action => 'index')

      end


    end


  end


  def redirect
    redirect = params.fetch(:url)
    url = Url.find_by redirect: redirect
    redirect_to url.origin

  end


  private

  def url_params
    params.require(:url).permit(:origin, :redirect)
  end
end
