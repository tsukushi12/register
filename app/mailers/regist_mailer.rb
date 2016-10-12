class RegistMailer < ApplicationMailer
  default from: "user@gmail.com"
  add_template_helper(ApplicationHelper)
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.regist_mailer.regist_bmail.subject
  #
  def regist_bmail(user, attr)
    @user = user
    @attr = attr
    mail to: @user.addr, subject: "ありがとうございますにゃん"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.regist_mailer.regist_amail.subject
  #
  def regist_amail(user, attr)
    @user = user
    @attr = attr
    mail to: @user.addr, subject: "ご予約ありがとうございますにゃん"
  end
end
