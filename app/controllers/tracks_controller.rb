require 'uri'

class TracksController < ApplicationController
  def add
    track = Track.new
    p '--------------'
    redirect = URI(track_params['redirect'])
    redirect.path[0] = ''
    p redirect.host
    if redirect.host != 'little.tw'
      flash[:error] = '請輸入正確短網址'
      redirect_to user_path and return
    end
    url = Url.find_by(:redirect => redirect.path)
    if url.nil?
      flash[:error] = '不存在的短網址'
      redirect_to user_path
    else
      current_user.tracks.each do |u|
        if url.id == u.url_id
          redirect_to user_path and return
        end
      end
      track.url_id = url.id
      track.user_id = current_user.id
      track.save
      redirect_to user_path
    end
  end


  def remove

  end

  private

  def track_params
    params.require(:url).permit(:redirect)
  end
end
