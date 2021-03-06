class RegistMailer < ApplicationMailer
  before_action :set_smtp_settings

  default from: "ヴェルにゃん"
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

  def regist_call_mail(address)
    mail to: address, subject: "公演30分前ですにゃん"
  end
  
  def sorry_mail(attr_id)
    @attr = Attr.find(attr_id)
    @user = User.where("addr = ? and status = ?", @attr.authenticated_addr, 1).last
    mail to: @attr.authenticated_addr, subject: "ごめんなさいにゃん！訂正にゃん！"
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
