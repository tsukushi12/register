class ApolloMailer < ApplicationMailer
  default from: "アポロ"
  add_template_helper(ApplicationHelper)

  def apollo_mail(attr)
    set_smtp_settings
    
    @attr = attr
    mail to: @attr.authenticated_addr, subject: "ありがとう"
  end
  
  private
  def set_smtp_settings
    ActionMailer::Base.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      domain:               'smtp.gmail.com',
      user_name:            ENV["APOLLO_G_ACCOUNT"],
      password:             ENV["APOLLO_G_PASS"],
      authentication:       'plain',
      enable_starttls_auto: true
    }
  end
end
