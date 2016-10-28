class AdminController < ApplicationController
  before_action :authenticated, except: [:info, :login, :authenticate, :attend, :apollo_mail_send]

  layout 'application_admin'

  # 管理画面
  def index
    @attrs = Attr.all
  end

  def info
    @attrs = Attr.all
  end

  # ログイン処理
  def authenticate
    require 'digest'
    username = Digest::SHA256.hexdigest(params[:username])
    password = Digest::SHA256.hexdigest(params[:password])
    username_digest = ENV['SECRET_A_USER']
    password_digest = ENV['SECRET_A_PASS']
    if username == username_digest && password == password_digest
      session[:admin] = 1
      redirect_to admin_url
    else
      redirect_to root_url
    end
  end

  def login
  end

  def logout
    reset_session
    redirect_to admin_login_path
  end

  def attend
    @attr = Attr.find(params[:attr_id])
    @attr.attended ? @attr.update(attended: false) : @attr.update(attended: true)

    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  # メール送る処理作る
  def call_mail_send
    attrs = Attr.where(time: params[:attr_time].to_time).where("authenticated_addr not ?", nil )

    attrs.each do |attr|
      RegistMailer.regist_call_mail(attr.authenticated_addr).deliver_later
      attr.update(mail1: true)
    end
    redirect_to :back, notice: '送信完了'
  end

  def apollo_mail_send
    attrs = Attr.where(time: params[:attr_time].to_time).where("authenticated_addr not ? and attended = ?", nil, true)
    Attr.where(time: params[:attr_time].to_time).update(status: 3)

    attrs.each do |attr|
      ApolloMailer.apollo_mail(attr).deliver_later
      attr.update(mail2: true)
      attr.user.update(status: 0)
    end
    redirect_to admin_url, notice: '送信完了'
  end

  private
  # ログインしてたらおっけー
  def authenticated
    redirect_to admin_login_url if session[:admin] != 1
  end
end
