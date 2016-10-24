class RegistMailer < ApplicationMailer
  before_action :set_smtp_settings

  default from: "wernyan.kobedenshi@gmail.com"
  add_template_helper(ApplicationHelper)

  def regist_bmail(user, attr)
    @user = user
    @attr = attr
    mail to: @user.addr, subject: "予約はまだ確定していないにゃん"
  end

  def regist_amail(user, attr)
    @user = user
    @attr = attr
    mail to: @user.addr, subject: "ご予約ありがとうございますにゃん"
  end

  def regist_call_mail(attr)
    @attr = attr
    @body = ''
    mail to: attr.authenticated_addr, subject: "公演がはじまりますにゃん"
  end

  private
  def set_smtp_settings
    ActionMailer::Base.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      domain:               'smtp.gmail.com',
      user_name:            ENV["SECRET_G_ACCOUNT"],
      password:             ENV["SECRET_G_PASS"],
      authentication:       'plain',
      enable_starttls_auto: true
    }
  end
end
