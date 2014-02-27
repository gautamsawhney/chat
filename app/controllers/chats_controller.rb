require "net/http"

class ChatsController < ApplicationController
  def room
    redirect_to login_path unless session[:username]
  end
  
  def new_message
    # faye = URI.parse 'http://localhost:9292/faye'
    
    # Check if the message is private
    if recipient = params[:message].match(/@(\w+) (.+)/)

      # It is private, send it to the recipient's channel
      
      @channel = "/messages/private/#{recipient.captures.first}"
      @message = { :username => session[:username], :msg => recipient.captures.second }
    else
      
      @channel = "/messages/public"
      @message = { :username => session[:username], :msg => params[:message] }
    end
    
    respond_to do |f|
      f.js
    end
  end
end
