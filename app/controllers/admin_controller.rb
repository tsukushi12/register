class AdminController < ApplicationController
  def index
    redirect_to root_url if session[:admin] != 1
    @attrs = Attr.all
  end
  
  def authenticate
    require 'digest'
    username = Digest::SHA256.hexdigest(params[:username])
    password = Digest::SHA256.hexdigest(params[:password])
    username_digest = ENV['SECRET_A_USER']
    password_digest = ENV['SECRET_A_PASS']
    if username == username_digest && password == password_digest
      session[:admin] = 1
      redirect_to admin_index_url
    else
      redirect_to root_url
    end
  end
  
  def logout
    reset_session
    redirect_to admin_login_path
  end
end
