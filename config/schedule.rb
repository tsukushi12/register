set :output, 'log/crontab.log'
set :environment, :production
env :PATH, ENV['PATH']
env :SECRET_G_ACCOUNT, ENV['SECRET_G_ACCOUNT']
env :SECRET_G_PASS, ENV['SECRET_G_PASS']

every '*/1 * 28-30 10 * ' do
  rake "mail:call_mail_delivery"
end
