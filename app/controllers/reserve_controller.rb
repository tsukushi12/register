class ReserveController < ApplicationController
  before_action :get_attr, :except => ['time_select', 'seat_select']
  before_action :attr_check, :only => ['time_select', 'seat_select']
  before_action :form_and_register_filter, :only => ['form', 'register']
  before_action :auth_and_cancel_filter, :only => ['auth', 'cancel_form', 'cancel']

  def time_select
    @attrs = Attr.all
  end

  def seat_select
    @id = params[:id].to_i
    if @id % 10 != 1 || @id > 500 || @id < 0
      redirect_to root_path, alert: "ごめんね。URLが見つからないよ"
    end
    @attrs = Attr.limit(10).offset(@id.to_i - 1)
  end

  def form
    @user = User.new
  end

  def register
    require 'digest'
    addr = user_params[:addr]
    @user = @attr.user.build(addr: addr, url: Digest::SHA256.hexdigest(addr))

      if @user.save
          @attr.update(status: 1)
          RegistMailer.regist_bmail(@user, @attr).deliver
          redirect_to(root_path, notice: "確認メールを送信したよ")
      else
        render :form
      end
  end

  def auth

    if @attr.status == 1 && @user && @user.attr_id == @attr.id
      if @user.update(status: 1)
        @attr.update(status: 2)
        RegistMailer.regist_amail(@user, @attr).deliver
        redirect_to root_path, notice: "予約完了メールを送信したよ。当日はメール画面を見せてね"
      else
        redirect_to root_path, alert: "ごめんね。座席が埋まってしまったみたい"
      end
    else
      redirect_to root_path, alert: "このURLはみつからないのにゃん"
    end
  end

  def cancel_form
    unless @user || @attr.status == 2 || @user.attr_id == @attr.id
      redirect_to root_path, alert: "このURLはみつからないのにゃん"
    end
  end

  def cancel
    if @user && @attr.status == 2 && @user.attr_id == @attr.id
      @user.update(status: 2)
      @attr.update(status: 0)
      redirect_to root_path, notice: "予約をキャンセルしたよ。。。"
    else
      redirect_to root_path, alert: "このURLはみつからないのにゃん"
    end
  end
  
  def help
  end

  private
  def get_attr
    @attr = Attr.find(params[:id])
  end

  def form_and_register_filter
    redirect_to(root_path, {alert: "ごめんね。座席が埋まってしまったみたい"}) unless @attr.status == 0
  end

  def attr_check
    @attr = Attr.where(status: 1).where("updated_at <= ?", 1.hours.ago)
    @attr.update(status: 0) if @attr
  end

  def auth_and_cancel_filter
    @user = User.where(url: params[:key]).last
  end

  def user_params
    params.require(:user).permit(:addr)
  end

end
