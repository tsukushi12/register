#!/bin/sh

kill `cat /var/tmp/unicorn.pid`
git pull
rails assets:precompile RAILS_ENV=production
unicorn -c config/unicorn.rb -E production -D
