class LineLinkageController < ApplicationController
  skip_before_action :require_login
  protect_from_forgery :except => [:callback]
  require 'securerandom'

  def get_token
    user_id = params[:user_id]
    link_token = create_link_token(user_id)
    binding.break
    send_link_message(user_id, link_token)
    render plain: "Success", status: 200
  end


  private

   # 連携トークンを発行
   def create_link_token(user_id)
    channel_access_token = ENV["LINE_CHANNEL_TOKEN"]
    uri = URI.parse("https://api.line.me/v2/bot/user/#{user_id}/linkToken")
    
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{channel_access_token}"
    
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    return JSON.parse(response.body)["linkToken"]
  end

end



