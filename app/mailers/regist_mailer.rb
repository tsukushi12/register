class RegistMailer < ApplicationMailer
  default from: "user@gmail.com"
  add_template_helper(ApplicationHelper)

  def regist_bmail(user, attr)
    @user = user
    @attr = attr
    mail to: @user.addr, subject: "ありがとうございますにゃん"
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
end