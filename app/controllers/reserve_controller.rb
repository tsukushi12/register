class ReserveController < ApplicationController
  before_action :get_attr, :except => ['time_select', 'seat_select']
  before_action :attr_check, :only => ['time_select', 'seat_select']

  def time_select
    @attrs = Attr.all
  end

  def seat_select
    @id = params[:id]
    @attrs = Attr.limit(10).offset(@id.to_i - 1)
  end

  def form
    @user = User.new
  end

  def register
    redirect_to action: :form, alert: "すでに座席が埋まってしまいました" unless @attr.status == 0

    require 'digest'
    addr = user_params[:addr]
    @user = @attr.user.build(addr: addr, url: Digest::SHA256.hexdigest(addr))

      if @user.save
        @attr.update!(status: 1)
        RegistMailer.regist_bmail(@user).deliver
      else
        render :form
      end
  end

  def auth
    @user = @attr.user.last

    @err = []
    @err = "すでに座席が埋まってしまいました" unless @attr.status == 1
    @err = "想定されていないURLです" unless @user
    @err = "URLが失効しています" unless @user.id == User.where(url: params[:key]).last.id
    if @err.empty?
        @user.update(status: 1)
        @attr.update(status: 2)
        RegistMailer.regist_amail(@user).deliver
    end
  end


  private
  def get_attr
    @attr = Attr.find(params[:id])
  end

  def attr_check
    @attr = Attr.where(status: 1).where("updated_at <= ?", 1.hours.ago)
    @attr.update(status: 0) if @attr
  end

  def user_params
    params.require(:user).permit(:addr)
  end

end
