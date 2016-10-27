namespace :mail do
  desc '公演30分前にメールを送る'

  task call_mail_delivery: :environment do
    attrs = Attr.where("time <= ? and mail1 == ? and authenticated_addr not ?", 30.minutes.since, false, nil)
    attrs.each do |attr|
      RegistMailer.regist_call_mail(attr.authenticated_addr).deliver
    end
  end
end
