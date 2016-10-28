namespace :mail do
  desc '公演30分前にメールを送る'

  task call_mail_delivery: :environment do
    attrs = Attr.where("time <= ? and mail1 = ? and authenticated_addr not ?", 30.minutes.since, false, nil)

    print Time.zone.now.strftime("[%Y/%m/%d-%H:%M:%S] ")
    if attrs.empty?
      puts 'Mail to send is nothing. Yay!'
    else
      print 'Sent to '
      attrs.each_with_index do |attr, i|
        RegistMailer.regist_call_mail(attr.authenticated_addr).deliver_now
        attr.update(mail1: true)
        if i != 0
          print ', '
        end
        print attr.authenticated_addr
      end
      puts '.'
    end
  end
end
