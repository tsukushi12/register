class ReserveController < ApplicationController
  before_action :get_attr, :except => ['time_select', 'seat_select']

  def time_select
    @attrs = Attr.all
  end

  def seat_select
    @id = params[:id]
    @attrs = Attr.limit(10).offset(@id.to_i - 1)
  end

  def form
  end

  def register
    raise unless @attr.status == 0

    require 'digest'
    addr = params[:page][:email]
    @user = @attr.user.build(addr: addr, url: Digest::SHA256.hexdigest(addr))

      @user.save!
      @attr.update!(status: 1)
      RegistMailer.regist_bmail(@user).deliver

    rescue => e
      @message = e.message
      render :error
  end

  def auth
    @user = @attr.user.last

    err = []
    err = "すでに座席が埋まってしまいました" unless @attr.status == 1
    err = "想定されていないURLです" unless @user
    err = "URLが失効しています" unless @user.id == User.where(url: params[:key]).last.id
    raise err unless err.empty?

        @user.update(status: 1)
        @attr.update(status: 2)
        RegistMailer.regist_amail(@user).deliver

    rescue => e
      @message = err
      render :error
  end

  private
  def get_attr
    @attr = Attr.find(params[:id])
  end

  def attr_check
    Attr.where()

  end

end
