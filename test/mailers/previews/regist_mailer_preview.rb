# Preview all emails at http://localhost:3000/rails/mailers/regist_mailer
class RegistMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/regist_mailer/regist_bmail
  def regist_bmail
    RegistMailer.regist_bmail
  end

  # Preview this email at http://localhost:3000/rails/mailers/regist_mailer/regist_amail
  def regist_amail
    RegistMailer.regist_amail
  end

end
