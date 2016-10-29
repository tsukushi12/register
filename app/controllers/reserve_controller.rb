class ReserveController < ApplicationController
  before_action :get_attr, :except => [:time_select, :seat_select, :help, :message, :resend_mail, :resend]
  before_action :attr_check, :only => [:time_select, :seat_select]
  before_action :form_and_register_filter, :only => [:form, :register]
  before_action :auth_and_cancel_filter, :only => [:auth, :cancel_form, :cancel]

  def time_select
    @attrs = Attr.all
  end

  def seat_select
    @id = params[:id].to_i
    if @id % 10 != 1 || @id > 500 || @id < 0
      redirect_to message_path, alert: "このURLはみつからないのにゃん"
    else
      @attrs = Attr.limit(10).offset(@id.to_i - 1)
    end
  end

  def form
    @user = User.new
  end

  def register
    require 'digest'
    addr = user_params[:addr]
    @user = @attr.user.build(addr: addr, addr_confirmation: user_params[:addr_confirmation], url: Digest::SHA256.hexdigest(addr))

    if @user.save
        @attr.update(status: 1) unless @attr.time.today?
        RegistMailer.regist_bmail(@user, @attr).deliver
        redirect_to(message_path, notice: "確認メールを送信したにゃん")
    else
      render :form
    end
  end

  def auth
    if @attr.time - Time.now < 5.minutes
      redirect_to message_path, alert: "予約は終了したにゃん"
    else
      flag = @attr.status == 1 || @attr.time.today?
      if flag && @user && @user.attr_id == @attr.id
        if @user.update(status: 1)
          @attr.update(status: 2, authenticated_addr: @user.addr, authenticated_at: Time.zone.now)
          if Time.zone.now + 30.minutes > @attr.time
            @attr.update(mail1: true)
          end
          RegistMailer.regist_amail(@user, @attr).deliver
          redirect_to message_path, notice: "予約完了メールを送信したにゃん"
        else
          redirect_to message_path, alert: "この座席はうまってしまったにゃん"
        end
      else
        redirect_to message_path, alert: "このURLはみつからないのにゃん"
      end
    end
  end

  def resend
  end

  def resend_mail
    if (attr = Attr.find_by(authenticated_addr: params[:addr]))
      RegistMailer.regist_amail(attr.user.where(status: 1).last, attr).deliver
    end
    redirect_to message_url, alert: 'メールを送信したにゃん'
  end

  def cancel_form
    unless @user || @attr.status == 2 || @user.attr_id == @attr.id
      redirect_to message_path, alert: "このURLはみつからないのにゃん"
    end
  end

  def cancel
    if @user && @attr.status == 2 && @user.attr_id == @attr.id
      @user.update_attribute(:status, 2)
      @attr.update(status: 0, authenticated_addr: nil, authenticated_at: nil, attended: false, mail1: false, mail2: false)
      redirect_to message_path, notice: "予約をキャンセルしたにゃん"
    else
      redirect_to message_path, alert: "このURLはみつからないのにゃん"
    end
  end

  def message
    redirect_to root_path unless flash[:notice].present? || flash[:alert].present?
  end

  private
  def get_attr
    @attr = Attr.find(params[:id])
  end

  def form_and_register_filter
    redirect_to(message_path, {alert: "この座席はうまってしまったにゃん"}) unless @attr.status == 0
  end

  def attr_check
    @attr = Attr.where(status: 1).where("updated_at <= ?", 15.minutes.ago)
    @attr.update(status: 0) if @attr
  end

  def auth_and_cancel_filter
    @user = User.where(url: params[:key]).last
  end

  def user_params
    params.require(:user).permit(:addr, :addr_confirmation)
  end
end
