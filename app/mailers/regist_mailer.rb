class RegistMailer < ApplicationMailer
  default from: "user@gmail.com"
  add_template_helper(ApplicationHelper)
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.regist_mailer.regist_bmail.subject
  #
  def regist_bmail(user)
    @user = user

    mail to: @user.addr, subject: "test"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.regist_mailer.regist_amail.subject
  #
  def regist_amail(user)
    @user = user

    mail to: @user.addr, subject: "test"
  end
end
